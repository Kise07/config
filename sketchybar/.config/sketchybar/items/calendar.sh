#!/bin/bash

sketchybar --add item calendar right                                   \
           --set calendar icon="$ICON_CALENDAR"                         \
                          update_freq=30                               \
                          script="$PLUGIN_DIR/calendar.sh"
