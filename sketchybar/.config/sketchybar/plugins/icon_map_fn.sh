#!/usr/bin/env bash
# Thin wrapper around sketchybar-app-font's v3.0.6 icon map.
# Keeps the original one-app-per-call interface used by front_app.sh and
# aerospace.sh, so call sites don't change.
#
# Map source: https://github.com/kvndrsslr/sketchybar-app-font/releases

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Sourcing (not executing) skips the v3 file's "print all args" entrypoint.
source "$DIR/icon_map_v3.sh"

__icon_map "$1"
printf '%s' "$icon_result"
