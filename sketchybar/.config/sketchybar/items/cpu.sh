#!/bin/bash

# Right-side strip: CPU percentage, refreshed every 2s by plugins/cpu.sh.
# (His items/cpu.sh instead drives the compiled helper/ binary over XPC —
# mach_helper never spawns it here, so it would stay frozen at "CPU".)
# Icon glyphs are Nerd Font codepoints (U+F2DB), hence the explicit font.
#
# label.font is 12 rather than the default 13: the strip is only 50px wide.
# background.padding_left/right = 6 opens the vertical gap between this row
# and the pills above/below it (in a right strip those paddings run
# vertically — that is what produced the 6px spacing, i.e. 3+3 from the
# global PADDINGS default).
sketchybar --add item cpu right                                        \
           --set cpu update_freq=2                                     \
                     icon="$ICON_CPU"                                  \
                     icon.font="MesloLGS Nerd Font:Bold:16.0"          \
                     icon.color=$BLACK                                 \
                     label.font="$FONT:Semibold:11.0"                  \
                     label.color=$BLACK                                \
                     icon.padding_left=2                               \
                     icon.padding_right=1                              \
                     label.padding_left=1                              \
                     label.padding_right=2                             \
                     background.drawing=on                             \
                     background.color=0xffb8c0e0                       \
                     background.height=26                              \
                     background.corner_radius=11                       \
                     background.padding_left=6                         \
                     background.padding_right=6                        \
                     script="$PLUGIN_DIR/cpu.sh"
