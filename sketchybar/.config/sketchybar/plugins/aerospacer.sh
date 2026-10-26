#!/bin/bash

# AeroSpace triggers `aerospace_workspace_change` with FOCUSED_WORKSPACE=...
# (see exec-on-workspace-change in aerospace.toml). Fall back to asking
# AeroSpace directly when run without that env (bar start / manual run).
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"

# Every workspace row keeps background.drawing=on at a FIXED height (22),
# so a focus change only swaps the background COLOUR (transparent <-> pill).
# Toggling `drawing` instead would change the row height and shove every
# item below it up/down on each workspace switch — that was the displacement.
if [ "$1" = "$FOCUSED" ]; then
  sketchybar --set "$NAME" background.color=0x44ffffff
else
  sketchybar --set "$NAME" background.color=0x00000000
fi
