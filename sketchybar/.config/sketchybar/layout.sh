#!/bin/bash

# ─────────────────────────────────────────────────────────────────────────
# layout.sh — flip SketchyBar between the two orientations:
#
#   ./layout.sh                show the current layout (default)
#   ./layout.sh vertical       right-edge strip   (rows stack top->bottom)
#   ./layout.sh horizontal     top bar            (items flow left->right)
#   ./layout.sh toggle         switch to the other one
#   ./layout.sh -h | --help
#
# What it does:
#   1. writes $CONFIG_DIR/.layout           -> sketchybarrc derives the bar
#                                              geometry + workspace pill
#                                              metrics from it
#   2. rewrites the two bar-reservation lines in aerospace.toml -> windows
#      stop reserving the old edge and start reserving the new one
#   3. `aerospace reload-config`           -> gaps apply immediately
#   4. `pkill -x sketchybar`               -> launchd (KeepAlive) respawns
#      the bar, re-reading sketchybarrc
#
# Nothing is committed anywhere; this only touches the state file, the two
# gap lines, and the running processes.
# ─────────────────────────────────────────────────────────────────────────

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
STATE="$CONFIG_DIR/.layout"
TOML="$HOME/.config/aerospace/aerospace.toml"

# Bar geometry (must mirror the case statement in sketchybarrc):
#   vertical   height=50 margin=10  -> rightmost 60px are the bar + inset
#   horizontal height=40 margin= 0  -> topmost 40px are the bar
# AeroSpace needs to keep windows clear of whichever edge that is.
BAR_H_VERTICAL=50
BAR_M_VERTICAL=10
BAR_H_HORIZONTAL=40
GAP_BREATHING=10          # the usual clear space we leave around windows

usage() {
  cat <<'EOF'
layout.sh — flip SketchyBar between the two orientations:

  layout.sh                show the current layout (default)
  layout.sh vertical       right-edge strip   (rows stack top->bottom)
  layout.sh horizontal     top bar            (items flow left->right)
  layout.sh toggle         switch to the other one
  layout.sh -h | --help

Writes the one-line state file .layout (gitignored), rewrites the two
bar-reservation gap lines in aerospace.toml, reloads AeroSpace and
restarts the bar. Nothing else in either config is touched.
EOF
}

current() { cat "$STATE" 2>/dev/null || echo vertical; }

case "${1:-}" in
  ""|-s|--show)
    echo "layout: $(current)"
    echo "  state file: $STATE"
    exit 0
    ;;
  -h|--help)
    usage
    exit 0
    ;;
  vertical|horizontal)
    TARGET="$1"
    ;;
  toggle)
    if [ "$(current)" = "vertical" ]; then TARGET=horizontal; else TARGET=vertical; fi
    ;;
  *)
    echo "layout.sh: unknown argument '$1'" >&2
    usage >&2
    exit 1
    ;;
esac

if [ "$TARGET" = "$(current)" ]; then
  echo "already in '$TARGET' layout"
  exit 0
fi

# ── 1. state file (sketchybarrc reads it on every bar start) ────────────
printf '%s\n' "$TARGET" > "$STATE"

# ── 2. AeroSpace bar reservation ────────────────────────────────────────
if [ "$TARGET" = "vertical" ]; then
  TOP=$GAP_BREATHING
  RIGHT=$((BAR_H_VERTICAL + BAR_M_VERTICAL + GAP_BREATHING))   # 50+10+10 = 70
else
  TOP=$((BAR_H_HORIZONTAL + GAP_BREATHING))                    # 40+10 = 50
  RIGHT=$GAP_BREATHING
fi

if [ -f "$TOML" ]; then
  sed -i '' -E "s/^gaps\.outer\.top = [0-9]+/gaps.outer.top = $TOP/" "$TOML"
  sed -i '' -E "s/^gaps\.outer\.right = [0-9]+/gaps.outer.right = $RIGHT/" "$TOML"
  # fail loudly rather than leave windows under the bar
  grep -q "^gaps\.outer\.top = $TOP\$" "$TOML" &&
  grep -q "^gaps\.outer\.right = $RIGHT\$" "$TOML" ||
    { echo "layout.sh: FAILED to rewrite gaps in $TOML" >&2; exit 1; }
else
  echo "layout.sh: warning, $TOML not found — gaps NOT adjusted" >&2
fi

# ── 3. apply the AeroSpace config ───────────────────────────────────────
aerospace reload-config >/dev/null 2>&1 \
  || echo "layout.sh: warning, 'aerospace reload-config' failed" >&2

# ── 4. restart the bar (launchd KeepAlive respawns it) ──────────────────
pkill -x sketchybar 2>/dev/null
# launchd respawns the process quickly, but it then needs several seconds
# before it accepts queries and has laid its items out — poll for a real
# answer from the bar, not merely for the process existing.
for _ in $(seq 1 30); do
  pgrep -x sketchybar >/dev/null 2>&1 || break
  sketchybar --query space.1 2>/dev/null | grep -q '"origin"' && break
  sleep 0.5
done
if ! pgrep -x sketchybar >/dev/null 2>&1; then
  # not managed by launchd on this box -> start it ourselves
  /opt/homebrew/bin/sketchybar >/dev/null 2>&1 &
  sleep 3
fi

echo "layout: $TARGET"
echo "  bar   : position=$([ "$TARGET" = vertical ] && echo right || echo top) height=$([ "$TARGET" = vertical ] && echo $BAR_H_VERTICAL || echo $BAR_H_HORIZONTAL) margin=$([ "$TARGET" = vertical ] && echo $BAR_M_VERTICAL || echo 0)"
echo "  gaps  : outer.top=$TOP outer.right=$RIGHT (aerospace reloaded)"
echo "  state : $STATE"

# Verify by geometry — sketchybar's own `position` field is unreliable in
# this build, but the first workspace row never lies: y=0 means the bar is
# running across the top, y>0 means it is running down the right edge.
# A freshly restarted bar reports -9999 until it has laid the items out,
# so keep polling until we get a real coordinate.
ROW=""
for _ in $(seq 1 20); do
  ROW=$(sketchybar --query space.1 2>/dev/null \
        | sed -n 's/.*"origin": \[[ ]*[0-9.]*, *\([0-9.]*\).*/\1/p' | head -1)
  case "$ROW" in ""|-*) sleep 0.5 ;; *) break ;; esac
done

case "$ROW" in
  ""|-*)
    echo "  check : skipped (bar not queryable yet)" >&2
    ;;
  0|0.*)
    if [ "$TARGET" = "horizontal" ]; then
      echo "  check : OK (workspace row at y=0 -> top bar)"
    else
      echo "  check : MISMATCH — row at y=0 but '$TARGET' wants the right strip" >&2
      exit 1
    fi
    ;;
  *)
    if [ "$TARGET" = "vertical" ]; then
      echo "  check : OK (workspace row at y=$ROW -> right strip)"
    else
      echo "  check : MISMATCH — row at y=$ROW but '$TARGET' wants the top bar" >&2
      exit 1
    fi
    ;;
esac
