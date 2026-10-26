#!/bin/bash

# front_app_switched (built-in event in this SketchyBar build) supplies the
# new app's name in $INFO; icon_map_fn.sh turns that name into a
# sketchybar-app-font token — ":ghostty:", ":helium:", ":default:".
# Docs: https://felixkratz.github.io/SketchyBar/config/events
#
# Bar start runs with SENDER=forced and an empty $INFO, so fall back to
# System Events for the app that owns the workspace right now.

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"

if [ "$SENDER" = "front_app_switched" ]; then
  APP="$INFO"
else
  # System Events reports the PROCESS name ("ghostty"), the map keys on the
  # display name ("Ghostty") -> retry capitalised below if nothing matched.
  APP=$(osascript -e 'tell application "System Events" to name of first application process whose frontmost is true' 2>/dev/null)
fi

ICON="$("$CONFIG_DIR/plugins/icon_map_fn.sh" "$APP")"
if [ "$ICON" = ":default:" ] && [ -n "$APP" ]; then
  CAPPED=$(printf '%s' "$APP" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')
  ICON="$("$CONFIG_DIR/plugins/icon_map_fn.sh" "$CAPPED")"
fi

sketchybar --set "$NAME" icon="$ICON"
