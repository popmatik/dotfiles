#!/bin/sh

# Get Spotify status using AppleScript
RUNNING=$(osascript -e 'application "Spotify" is running')

if [ "$RUNNING" = "false" ]; then
  sketchybar --set "$NAME" label="" icon="" drawing=off
  exit 0
fi

# Get player state
STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)

if [ "$STATE" = "playing" ]; then
  # Get track info
  TRACK=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)
  ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)

  # Format the display
  if [ -n "$TRACK" ] && [ -n "$ARTIST" ]; then
    sketchybar --set "$NAME" label="$TRACK - $ARTIST" icon="" drawing=on
  else
    sketchybar --set "$NAME" label="Spotify" icon="" drawing=on
  fi
else
  # Spotify is open but paused/stopped
  sketchybar --set "$NAME" label="Paused" icon="" drawing=on
fi
