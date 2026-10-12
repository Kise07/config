#!/bin/bash

# AeroSpace workspaces as SketchyBar items.
# This replaces Josean's yabai / Mission-Control `space` component.
#
# AeroSpace drives the highlight through aerospace.toml:
#   exec-on-workspace-change = ['/bin/bash', '-c',
#     'sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE']

sketchybar --add event aerospace_workspace_change

# Workspaces shown as pills. Must match aerospace.toml's
# `persistent-workspaces` — the plugin derives everything from the sid, so
# this list is the single place that decides how many pills appear.
WORKSPACES=(1 2 3 4 5)

for sid in "${WORKSPACES[@]}"; do
  sketchybar --add item space.$sid left                            \
             --subscribe space.$sid aerospace_workspace_change     \
             --set space.$sid                                      \
                   icon="$sid"                                     \
                   icon.color=$ACCENT_COLOR                        \
                   label.font="sketchybar-app-font:Regular:16.0"   \
                   label.color=$ACCENT_COLOR                       \
                   label.padding_right=20                          \
                   label.y_offset=-1                               \
                   background.color=$ACCENT_COLOR                  \
                   background.corner_radius=5                      \
                   background.drawing=off                          \
                   click_script="aerospace workspace $sid"         \
                   script="$PLUGIN_DIR/aerospace.sh $sid"
done

# Decorative separator between the workspaces and the front-app item
sketchybar --add item space_separator left                         \
           --set space_separator icon="$ICON_SEPARATOR"            \
                                 icon.color=$ACCENT_COLOR          \
                                 icon.padding_left=14              \
                                 icon.padding_right=14             \
                                 label.drawing=off                 \
                                 background.drawing=off
