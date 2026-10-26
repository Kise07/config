#!/bin/bash

# Directly BELOW the chevron: the icon of the app owning the focused
# workspace (Ghostty -> :ghostty:, Helium -> :helium:, ...).
#
# Placed here by sourcing this file straight after items/spaces.sh, since
# `left` items stack top-to-bottom in source order.
# icon.font is sketchybar-app-font (kvndrsslr's map, restored from the old
# top-bar setup) — icon_map_v3.sh emits :token: values only that font draws.
# Glyphs are monochrome (glyf only), hence icon.color=$WHITE.
sketchybar --add item front_app left                                    \
           --set front_app script="$PLUGIN_DIR/front_app.sh"            \
                           icon.font="sketchybar-app-font:Regular:16.0" \
                           icon.color=$WHITE                            \
                           label.drawing=off                            \
                           background.padding_left=8                    \
                           background.padding_right=8                   \
           --subscribe front_app front_app_switched
