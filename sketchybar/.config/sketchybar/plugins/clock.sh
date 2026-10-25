#!/bin/sh

# Bottom pill: clock only. Refreshed every second by update_freq.
sketchybar --set "$NAME" label="$(date '+%H:%M')"
