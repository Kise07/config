#!/bin/bash

# Battery pill: pmset is the only battery source on macOS.
# Sample line:
#   -InternalBattery-0 (id=27918435)	73%; charging; 1:45 remaining ...
#
# Icon is a plain bolt (ICON_BAT) — the percentage carries the information,
# so no level-glyph state machine here.

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

LINE=$(pmset -g batt | grep -E 'InternalBattery|Battery' | head -1)
PCT=$(printf '%s' "$LINE" | grep -Eo '[0-9]+%' | tr -d '%' | head -1)
[ -n "$PCT" ] || PCT=0

sketchybar --set "$NAME" icon="$ICON_BAT" label="${PCT}%"
