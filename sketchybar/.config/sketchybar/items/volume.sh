#!/bin/bash

# Right-side strip: TOP row of the bottom group — speaker glyph + percentage.
# Icon glyphs are Nerd Font codepoints (U+F026..), so icon.font is pinned —
# the bar default is SF Pro Text, which does not carry them.
#
# All three percentage rows (volume, cpu, battery) share identical metrics
# so the icons line up in size:
#   icon 12 (7.2px) + label 11 ("100%" = 31.0px) + 4px padding
#   = 42.2 of the 50px strip  ->  3-digit readouts never touch the edge.
sketchybar --add item volume right                                     \
           --set volume script="$PLUGIN_DIR/volume.sh"                 \
                        icon.font="MesloLGS Nerd Font:Bold:12.00"       \
                        icon.color=$BLACK                               \
                        label.font="$FONT:Semibold:11.0"                \
                        label.color=$BLACK                              \
                        icon.padding_left=1                             \
                        icon.padding_right=1                            \
                        label.padding_left=1                            \
                        label.padding_right=1                           \
                        background.drawing=on                           \
                        background.color=0xffb8c0e0                     \
                        background.height=26                            \
                        background.corner_radius=11                     \
                        background.padding_left=6                       \
                        background.padding_right=6                      \
           --subscribe volume volume_change
