#!/bin/bash

# front_app_switched supplies the new app's name in $INFO.
# Docs: https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set "$NAME" label="$INFO" \
                           icon="$("$CONFIG_DIR/plugins/icon_map_fn.sh" "$INFO")"
fi
