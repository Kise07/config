#!/bin/bash

# Right-side strip: CPU percentage, refreshed every 2s by plugins/cpu.sh.
# (His items/cpu.sh instead drives the compiled helper/ binary over XPC —
# mach_helper never spawns it here, so it would stay frozen at "CPU".)
# Icon glyphs are Nerd Font codepoints (U+F2DB), hence the explicit font.
sketchybar --add item cpu right                                        \
           --set cpu update_freq=2                                     \
                     icon="$ICON_CPU"                                  \
                     icon.font="MesloLGS Nerd Font:Bold:16.0"          \
                     script="$PLUGIN_DIR/cpu.sh"
