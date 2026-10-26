#!/bin/bash

# The glyph under the chevron shows the app that owns the FOCUSED
# WORKSPACE — and nothing at all when that workspace is empty.
#
# Two triggers, both just re-derive from AeroSpace's own window list:
#   front_app_switched        -> app focus changed
#   aerospace_workspace_change-> workspace changed (FOCUSED_WORKSPACE=...)
# Bar start (SENDER=forced) takes the same path, so no osascript fallback.
#
# Window list format (default): "<id> | <app-name> | <title>"
# The focused window wins if it lives on the focused workspace,
# otherwise the workspace's first window is shown.

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"

WS="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"

# fields are separated by " | "
field() { printf '%s' "$1" | awk -F ' \\| ' -v n="$2" '{print $n}'; }

FOCUSED_LINE=$(aerospace list-windows --focused 2>/dev/null | head -1)
FOCUSED_ID=$(field "$FOCUSED_LINE" 1)
FOCUSED_APP=$(field "$FOCUSED_LINE" 2)

WS_IDS=$(aerospace list-windows --workspace "$WS" 2>/dev/null | awk -F ' \\| ' '{print $1}')

if [ -n "$FOCUSED_ID" ] && [ -n "$WS_IDS" ] && printf '%s\n' "$WS_IDS" | grep -qx "$FOCUSED_ID"; then
  APP="$FOCUSED_APP"
else
  APP=$(aerospace list-windows --workspace "$WS" 2>/dev/null | head -1 | awk -F ' \\| ' '{print $2}')
fi

if [ -z "$APP" ]; then
  # empty workspace -> no glyph at all
  sketchybar --set "$NAME" icon=""
  exit 0
fi

ICON=$("$CONFIG_DIR/plugins/icon_map_fn.sh" "$APP")
if [ "$ICON" = ":default:" ]; then
  # System Events style lowercase names ("ghostty") vs map keys ("Ghostty")
  CAPPED=$(printf '%s' "$APP" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')
  [ "$CAPPED" != "$APP" ] && ICON=$("$CONFIG_DIR/plugins/icon_map_fn.sh" "$CAPPED")
fi

sketchybar --set "$NAME" icon="$ICON"
