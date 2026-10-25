#!/bin/bash

# Right-side strip: sits at the BOTTOM of the bar (above/below cpu).
# Icon glyphs are Nerd Font codepoints (U+F026..), so icon.font is pinned —
# the bar default is SF Pro Text, which does not carry them.
sketchybar --add item volume right                                     \
           --set volume script="$PLUGIN_DIR/volume.sh"                 \
                        icon.font="MesloLGS Nerd Font:Bold:16.0"        \
           --subscribe volume volume_change
