#!/usr/bin/env sh

sketchybar --add event aerospace_workspace_change
RED=0xffed8796
for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item "space.$sid" left \
        --subscribe "space.$sid" aerospace_workspace_change \
        --set "space.$sid" \
        icon="$sid" \
        icon.padding_left=22                          \
        icon.padding_right=22                         \
        icon.align=center                             \
        label.padding_right=33                        \
        icon.highlight_color=$RED                     \
        background.corner_radius=5                    \
        background.height=22                          \
        background.drawing=on                         \
        background.color=0x00000000                   \
        label.font="sketchybar-app-font:Regular:16.0" \
        label.background.height=22                    \
        label.background.drawing=off                  \
        label.background.color=0xff494d64             \
        label.background.corner_radius=11             \
        label.drawing=off                             \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospacer.sh $sid"
done

# Chevron: icon-only, centred in the strip so it lines up with the
# workspace numbers above and the app icon below.
sketchybar   --add item       separator left                          \
             --set separator  icon=                                 \
                              icon.font="MesloLGS Nerd Font:Regular:16.0" \
                              icon.align=center                       \
                              background.padding_left=6               \
                              background.padding_right=6              \
                              label.drawing=off
