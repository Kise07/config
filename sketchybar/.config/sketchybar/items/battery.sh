#!/bin/bash

# Bottom group (source order: clock, battery, cpu, volume — the first-sourced
# right item lands at the LOWEST position):
#
#   volume  ─┐
#   cpu      │
#   battery  │  top -> bottom
#   clock   ─┘
#
# Battery: U+26A1 lightning (ICON_BAT in colors.sh) + percentage from pmset
# (plugins/battery.sh), 30s tick. Same pill styling as its neighbours.
# Metrics shared with volume/cpu so all three icons match:
#   icon 12 (7.2px) + label 11 ("100%" = 31.0px) + 4px padding = 42.2 / 50px.
sketchybar --add item battery right                                     \
           --set battery script="$PLUGIN_DIR/battery.sh"               \
                         update_freq=30                                 \
                         icon.font="MesloLGS Nerd Font:Bold:12.00"       \
                         icon.color=$BLACK                              \
                         label.font="$FONT:Semibold:11.0"               \
                         label.color=$BLACK                             \
                         icon.padding_left=1                            \
                         icon.padding_right=1                           \
                         label.padding_left=1                           \
                         label.padding_right=1                          \
                         background.drawing=on                          \
                         background.color=0xffb8c0e0                    \
                         background.height=26                           \
                         background.corner_radius=11                    \
                         background.padding_left=6                      \
                         background.padding_right=6
