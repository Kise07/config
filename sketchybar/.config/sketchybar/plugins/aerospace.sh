#!/bin/bash

# Usage: aerospace.sh <sid>   (invoked by the space.$sid item)
# Highlights the focused workspace and shows the app icons of its windows.

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

SID="$1"
NAME="space.$SID"

# On the event AeroSpace passes FOCUSED_WORKSPACE. On initial load, ask AeroSpace.
FOCUS="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"

if [ "$SID" = "$FOCUS" ]; then
  # Focused: filled accent pill, dark text on top (the only coloured element
  # on the left — matches the reference bar where just the active workspace
  # is highlighted and every other item stays neutral).
  sketchybar --set "$NAME" background.drawing=on \
                           icon.color=$BAR_COLOR \
                           label.color=$BAR_COLOR
else
  # Unfocused: NO background, number in bright white and the app-icon strip
  # muted to SUBTEXT — reference-style hierarchy where the eye lands on the
  # focused pill first instead of a row of accent-coloured numbers.
  sketchybar --set "$NAME" background.drawing=off \
                           icon.color=$WHITE \
                           label.color=$SUBTEXT
fi

# App icons for the windows currently in this workspace
apps=$(aerospace list-windows --workspace "$SID" --format '%{app-name}' 2>/dev/null)
if [ -n "$apps" ]; then
  icon_strip=" "
  while IFS= read -r app; do
    [ -n "$app" ] && icon_strip+=" $("$CONFIG_DIR/plugins/icon_map_fn.sh" "$app")"
  done <<< "$apps"
  sketchybar --set "$NAME" label="$icon_strip"
else
  sketchybar --set "$NAME" label=" —"
fi
