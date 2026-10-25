#!/bin/bash

# Right-side strip: middle pill of the bottom group (volume above, clock below).
# Icon glyphs are Nerd Font codepoints (U+F026..), so icon.font is pinned —
# the bar default is SF Pro Text, which does not carry them.
# Icon ONLY: the glyph already encodes the level (mute/low/med/high), so
# label.drawing stays off. Same light grey-blue pill as the other rows.
sketchybar --add item volume right                                     \
           --set volume script="$PLUGIN_DIR/volume.sh"                 \
                        icon.font="MesloLGS Nerd Font:Bold:16.0"        \
                        icon.color=$BLACK                               \
                        icon.align=center                               \
                        label.drawing=off                               \
                        background.drawing=on                           \
                        background.color=0xffb8c0e0                     \
                        background.height=26                            \
                        background.corner_radius=11                     \
                        background.padding_left=6                       \
                        background.padding_right=6                      \
                        icon.padding_left=8                             \
                        icon.padding_right=8                            \
           --subscribe volume volume_change
