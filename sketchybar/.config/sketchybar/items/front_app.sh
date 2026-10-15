#!/bin/bash

# Plain text: no accent pill anymore (transparent-bar style).
# icon/label were $BAR_COLOR (near-black) because they sat ON the accent
# pill; without a pill that text would vanish against the wallpaper, so it
# becomes $WHITE like every other bare item.
sketchybar --add item front_app left                                   \
           --set front_app icon.color=$WHITE                           \
                           icon.font="sketchybar-app-font:Regular:16.0" \
                           label.color=$WHITE                          \
                           script="$PLUGIN_DIR/front_app.sh"           \
           --subscribe front_app front_app_switched
