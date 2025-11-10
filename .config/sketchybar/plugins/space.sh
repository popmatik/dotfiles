#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

# Catppuccin Mocha colors
OVERLAY0=0xff6c7086
SURFACE2=0xff585b70
SURFACE1=0xff45475a
SURFACE0=0xff313244
MAUVE=0xffcba6f7

if [ "$SELECTED" = "true" ]; then
  sketchybar --animate sin 10 --set "$NAME" background.color=$MAUVE background.drawing=on
else
  sketchybar --animate sin 10 --set "$NAME" background.color=$SURFACE1 background.drawing=on
fi
