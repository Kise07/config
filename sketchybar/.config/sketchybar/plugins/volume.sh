#!/bin/bash

# volume_change supplies the current volume percentage in $INFO.

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
    [6-9][0-9]|100)   ICON="$ICON_VOL_HIGH" ;;
    [3-5][0-9])       ICON="$ICON_VOL_MED"  ;;
    [1-9]|[1-2][0-9]) ICON="$ICON_VOL_LOW"  ;;
    *)                ICON="$ICON_VOL_MUTE" ;;
  esac

  # Icon only: items/volume.sh turns label.drawing off, so no "NN%" here.
  sketchybar --set "$NAME" icon="$ICON"
fi
