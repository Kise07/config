#!/bin/bash

# Bottom-most pill (first-sourced = lowest in the right strip): the time.
# icon is off — this row is just "14:57" in his calendar-pill styling:
# light grey-blue fill, black text, 26px tall, radius 11.
sketchybar --add item clock right                                       \
           --set clock script="$PLUGIN_DIR/clock.sh"                    \
                       update_freq=1                                    \
                       label.font="$FONT:Semibold:12.0"                 \
                       label.color=$BLACK                               \
                       label.align=center                               \
                       icon.drawing=off                                 \
                       background.drawing=on                            \
                       background.color=0xffb8c0e0                      \
                       background.height=26                             \
                       background.corner_radius=11                      \
                       background.padding_left=6                        \
                       background.padding_right=6                       \
                       icon.padding_left=8                              \
                       icon.padding_right=8
