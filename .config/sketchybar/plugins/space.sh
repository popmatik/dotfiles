#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

. "$CONFIG_DIR/colors.sh"

if [ "$SELECTED" = "true" ]; then
  sketchybar --animate sin 10 --set "$NAME" background.color=$MAUVE background.drawing=on
else
  sketchybar --animate sin 10 --set "$NAME" background.color=$SURFACE1 background.drawing=on
fi
