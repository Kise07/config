#!/bin/bash

# Media sits on SketchyBar's dedicated `center` position, so it is anchored
# to the true horizontal middle of the bar and stays there no matter how
# wide the left (workspaces + front app) or right (calendar/volume/battery/
# cpu) groups grow. A `right`-position item would drift left as the right
# group widens, which is not "centered".
#
# Styled as the reference bar's centre widget: filled accent pill with dark
# text — the second coloured element on the bar besides the focused
# workspace pill. The plugin only sets `label`/`drawing`, so these colours
# persist across updates.
sketchybar --add item media center                                      \
           --set media label.color=$BAR_COLOR                           \
                       label.max_chars=30                               \
                       icon="$ICON_MUSIC"                               \
                       icon.color=$BAR_COLOR                            \
                       background.drawing=on                            \
                       background.color=$ACCENT_COLOR                   \
                       background.corner_radius=5                       \
                       scroll_texts=on                                  \
                       update_freq=2                                    \
                       script="$PLUGIN_DIR/media.sh"
