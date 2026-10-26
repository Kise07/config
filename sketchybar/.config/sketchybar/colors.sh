#!/usr/bin/env sh

# Color Palette
BLACK=0xff181926
WHITE=0xffcad3f5
RED=0xffed8796
GREEN=0xffa6da95
BLUE=0xff8aadf4
YELLOW=0xffeed49f
ORANGE=0xfff5a97f
MAGENTA=0xffc6a0f6
GREY=0xff939ab7
TRANSPARENT=0x00000000

# General bar colors
BAR_COLOR=0xcc24273a #$GREY # Grey bar
ICON_COLOR=$WHITE # Color of all icons
LABEL_COLOR=$WHITE # Color of all labels

POPUP_BACKGROUND_COLOR=$BLACK
POPUP_BORDER_COLOR=$WHITE

SHADOW_COLOR=$BLACK

# Item specific special colors
SPOTIFY_GREEN=$GREEN

# --- Volume / CPU glyphs (kept from our previous config). Nerd Font codepoints,
# so items/volume.sh and items/cpu.sh pin icon.font to MesloLGS Nerd Font ---
export ICON_VOL_HIGH=
export ICON_VOL_MED=
export ICON_VOL_LOW=
export ICON_VOL_MUTE=
export ICON_CPU=

# --- Battery glyph: U+26A1 lightning (in the Nerd Font, so monochrome) ---
export ICON_BAT="⚡"   # U+26A1 high-voltage (oct-zap in the Nerd Font)
