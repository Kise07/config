#!/bin/bash

# Now-playing label via nowplaying-cli (polled by the item's update_freq=2),
# so no external "media_change" event provider is needed.

title=$(nowplaying-cli get title 2>/dev/null)
artist=$(nowplaying-cli get artist 2>/dev/null)
rate=$(nowplaying-cli get playbackRate 2>/dev/null)

if [ -n "$title" ] && [ "$rate" = "1" ]; then
  if [ -n "$artist" ]; then
    label="$artist - $title"
  else
    label="$title"
  fi
  sketchybar --set "$NAME" label="$label" drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
