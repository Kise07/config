#!/bin/bash
# ─────────────────────────────────────────────────────────────────────
# AeroSpace session helpers
#
# Binds SketchyBar + JankyBorders to AeroSpace's lifetime:
#   start -> when AeroSpace starts (invoked by after-startup-command)
#   stop  -> when AeroSpace quits (this script waits, then kills them)
#
# Why a script instead of `brew services`:
#   launchd services start at login and keep_alive themselves forever, so
#   the bar and focus border would keep running with no window manager.
#   Here, nothing runs unless AeroSpace is running.
#
# Why a separate process at all:
#   AeroSpace has no "on-exit" callback, so this watcher detaches via
#   exec-and-forget, waits for AeroSpace to disappear, then tears down.
#
# ── Startup race ─────────────────────────────────────────────────────
# after-startup-command can fire before `pgrep -x AeroSpace` sees the app,
# and AeroSpace's own process may still be settling at that instant. If we
# treated "not detected yet" as "AeroSpace exited", we'd tear the bar down
# straight after starting it (exactly the "flashes for a second then
# disappears" symptom). Phase 1 therefore REQUIRES a sustained observation
# of AeroSpace before teardown is ever allowed.
#
# Debug trace: tail -f ~/.cache/aerospace-helpers.log
# ─────────────────────────────────────────────────────────────────────
set -u

CACHE="$HOME/.cache"
LOCK="$CACHE/aerospace-helpers.pid"
LOG="$CACHE/aerospace-helpers.log"

# AeroSpace CLI on its absolute path. A GUI-spawned child often has a thin
# PATH that may not include /opt/homebrew/bin, so never rely on lookup.
AS=/opt/homebrew/bin/aerospace

# How long to keep looking for AeroSpace before giving up (seconds).
STARTUP_WAIT=20
# How long AeroSpace must stay gone before we tear the helpers down.
# Protects against a quick quit-and-relaunch racing the watcher.
GRACE=3

log() { printf '%s  %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >> "$LOG"; }

# Detect whether AeroSpace itself is alive.
# `aerospace` CLI is authoritative: it talks to the live app over XPC, so it
# works even if `pgrep` cannot see the process from AeroSpace's own spawn
# context. pgrep is kept only as a secondary fallback.
is_aerospace_running() {
  if [ -x "$AS" ] && "$AS" list-workspaces --all >/dev/null 2>&1; then
    return 0
  fi
  pgrep -x AeroSpace >/dev/null 2>&1 && return 0
  pgrep -f 'AeroSpace\.app/Contents/MacOS/AeroSpace' >/dev/null 2>&1
}

# One-shot diagnostic dump so a failed launch explains itself in the log.
debug_state() {
  log "DEBUG PATH=$PATH"
  log "DEBUG AS=$AS exists=$([ -x "$AS" ] && echo yes || echo no)"
  if [ -x "$AS" ]; then
    "$AS" list-workspaces --all > /tmp/.as_cli_out.$$ 2>/tmp/.as_cli_err.$$
    log "DEBUG AS CLI rc=$? out=$(tr '\n' ' ' < /tmp/.as_cli_out.$$) err=$(tr '\n' ' ' < /tmp/.as_cli_err.$$)"
    rm -f /tmp/.as_cli_out.$$ /tmp/.as_cli_err.$$
  fi
  log "DEBUG pgrep -x AeroSpace rc=$(pgrep -x AeroSpace >/dev/null 2>&1; echo $?) out=$(pgrep -x AeroSpace 2>/dev/null | tr '\n' ' ')"
  log "DEBUG ps match: $(ps -axo pid,comm 2>/dev/null | grep -i '[Aa]ero[Ss]pace' | head -3 | tr '\n' ' | ')"
  log "DEBUG self pid=$$ ppid=$PPID"
}

start_helpers() {
  # Kill leftovers from a previous session so we never stack instances.
  /usr/bin/pkill -x sketchybar 2>/dev/null
  /usr/bin/pkill -x borders    2>/dev/null
  sleep 0.3

  # sketchybar reads ~/.config/sketchybar/sketchybarrc on start.
  # Absolute paths again: a thin GUI PATH can miss /opt/homebrew/bin.
  /opt/homebrew/bin/sketchybar >/dev/null 2>&1 &
  # borders run with no arguments executes ~/.config/borders/bordersrc
  # (see: man borders — "we try to execute a file at ~/.config/borders/bordersrc").
  /opt/homebrew/bin/borders    >/dev/null 2>&1 &
}

stop_helpers() {
  /usr/bin/pkill -x sketchybar 2>/dev/null
  /usr/bin/pkill -x borders    2>/dev/null
}

mkdir -p "$CACHE"

# ── Watcher singleton guard ───────────────────────────────────────────
# If a watcher is already alive (AeroSpace restarted, or it was invoked
# twice), don't stack another one — just make sure the helpers are up.
if [ -f "$LOCK" ] && kill -0 "$(cat "$LOCK")" 2>/dev/null; then
  log "watcher already alive (pid $(cat "$LOCK")) -> refreshing helpers only"
  start_helpers
  exit 0
fi

echo $$ > "$LOCK"
trap 'rm -f "$LOCK"' EXIT
log "watcher started (pid $$)"

start_helpers
log "sketchybar+borders started (sketchybar=$(pgrep -x sketchybar | wc -l | tr -d ' ') borders=$(pgrep -x borders | wc -l | tr -d ' '))"

# ── Phase 1: wait for a SUSTAINED observation of AeroSpace ────────────
# Diagnostics first, so if detection never succeeds the log self-reports.
debug_state
waited=0
while ! is_aerospace_running; do
  sleep 1
  waited=$((waited + 1))
  if [ "$waited" -ge "$STARTUP_WAIT" ]; then
    log "FAIL: AeroSpace never became visible after ${waited}s -> stopping helpers"
    debug_state
    stop_helpers
    exit 1
  fi
done
log "AeroSpace detected after ${waited}s (AS CLI: $(/opt/homebrew/bin/aerospace list-workspaces --all 2>/dev/null | tr '\n' ' ') | pgrep: $(pgrep -x AeroSpace | tr '\n' ' '))"

# ── Phase 2: watch until AeroSpace actually quits ──────────────────────
misses=0
while :; do
  if is_aerospace_running; then
    misses=0
  else
    misses=$((misses + 1))
    # Require several consecutive misses before believing AeroSpace is gone;
    # guards against a single flaky probe tearing the bar down.
    [ "$misses" -ge 3 ] && break
  fi
  sleep 2
done
log "AeroSpace disappeared (confirmed $((misses * 2))s of failed probes)"

# Grace period: a quick relaunch hands over to the new session.
sleep "$GRACE"
if is_aerospace_running; then
  log "AeroSpace back within grace period -> leaving helpers running"
  exit 0
fi

stop_helpers
log "helpers stopped (sketchybar=$(pgrep -x sketchybar | wc -l | tr -d ' ') borders=$(pgrep -x borders | wc -l | tr -d ' '))"
