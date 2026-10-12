#!/bin/bash

# Media sits on SketchyBar's dedicated `center` position, so it is anchored
# to the true horizontal middle of the bar and stays there no matter how
# wide the left (workspaces + front app) or right (calendar/volume/battery/
# cpu) groups grow. A `right`-position item would drift left as the right
# group widens, which is not "centered".
sketchybar --add item media center                                      \
           --set media label.color=$ACCENT_COLOR                        \
                       label.max_chars=40                               \
                       icon="$ICON_MUSIC"                               \
                       icon.color=$ACCENT_COLOR                         \
                       background.drawing=off                           \
                       scroll_texts=on                                  \
                       update_freq=2                                    \
                       script="$PLUGIN_DIR/media.sh"
