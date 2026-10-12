#!/bin/bash

sketchybar --add item cpu right                                        \
           --set cpu update_freq=2                                     \
                     icon="$ICON_CPU"                                  \
                     script="$PLUGIN_DIR/cpu.sh"
