#!/bin/bash

# Right-side strip: second row of the bottom group — CPU percentage
# (refreshed every 2s by plugins/cpu.sh).
# (His items/cpu.sh instead drives the compiled helper/ binary over XPC —
# mach_helper never spawns it here, so it would stay frozen at "CPU".)
# Icon glyphs are Nerd Font codepoints (U+F2DB), hence the explicit font.
#
# Metrics shared with volume/battery so all three icons match:
#   icon 12 (7.2px) + label 11 ("100%" = 31.0px) + 4px padding = 42.2 / 50px.
# background.padding_left/right = 6 opens the vertical gap between pills
# (in a right strip those paddings run vertically — that is what produced
# the 6px spacing, i.e. 3+3 from the global PADDINGS default).
sketchybar --add item cpu right                                        \
           --set cpu update_freq=2                                     \
                     icon="$ICON_CPU"                                  \
                     icon.font="MesloLGS Nerd Font:Bold:12.00"          \
                     icon.color=$BLACK                                 \
                     label.font="$FONT:Semibold:11.0"                  \
                     label.color=$BLACK                                \
                     icon.padding_left=1                               \
                     icon.padding_right=1                              \
                     label.padding_left=1                              \
                     label.padding_right=1                             \
                     background.drawing=on                             \
                     background.color=0xffb8c0e0                       \
                     background.height=26                              \
                     background.corner_radius=11                       \
                     background.padding_left=6                         \
                     background.padding_right=6                        \
                     script="$PLUGIN_DIR/cpu.sh"
