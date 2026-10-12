#!/bin/bash

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

PERCENTAGE=$(pmset -g batt | grep -Eo "[0-9]+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

case "$PERCENTAGE" in
  9[0-9]|100) ICON="$ICON_BAT_FULL"  ;;
  [6-8][0-9]) ICON="$ICON_BAT_3Q"    ;;
  [3-5][0-9]) ICON="$ICON_BAT_HALF"  ;;
  [1-2][0-9]) ICON="$ICON_BAT_1Q"    ;;
  *)          ICON="$ICON_BAT_EMPTY" ;;
esac

if [ -n "$CHARGING" ]; then
  ICON="$ICON_BAT_CHARGING"
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
