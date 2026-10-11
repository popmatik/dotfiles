#!/bin/sh

# Load Navidrome credentials from a secure location
# Option 1: From a .env file in home directory (not in git repo)
if [ -f "$HOME/.navidrome.env" ]; then
    . "$HOME/.navidrome.env"
fi

# Option 2: From macOS Keychain (most secure)
# Uncomment these lines if you want to use Keychain instead
# NAVIDROME_URL=$(security find-generic-password -s "navidrome-url" -w 2>/dev/null)
# NAVIDROME_USER=$(security find-generic-password -s "navidrome-user" -w 2>/dev/null)
# NAVIDROME_PASSWORD=$(security find-generic-password -s "navidrome-password" -w 2>/dev/null)

# The variables should already be set from the .env file or keychain above
# Only use defaults if they're still not set
NAVIDROME_URL="${NAVIDROME_URL}"
NAVIDROME_USER="${NAVIDROME_USER}"
NAVIDROME_PASSWORD="${NAVIDROME_PASSWORD}"

# Check if credentials are configured
if [ -z "$NAVIDROME_URL" ] || [ -z "$NAVIDROME_USER" ] || [ -z "$NAVIDROME_PASSWORD" ]; then
    sketchybar --set "$NAME" label="Navidrome not configured" icon="󰎈" drawing=on
    exit 1
fi

# Check if jq is installed for better JSON parsing
HAS_JQ=$(command -v jq >/dev/null 2>&1 && echo "true" || echo "false")

# Function to make API calls to Navidrome
navidrome_api_call() {
    endpoint="$1"
    # Using plaintext password authentication (p parameter)
    # Note: This is sent over HTTP, so only use on localhost or with HTTPS
    response=$(curl -s -w "\n%{http_code}" \
        "${NAVIDROME_URL}/rest/${endpoint}?u=${NAVIDROME_USER}&p=${NAVIDROME_PASSWORD}&v=1.16.1&c=sketchybar&f=json")

    http_code=$(echo "$response" | tail -1)
    body=$(echo "$response" | sed '$d')

    if [ "$http_code" != "200" ]; then
        return 1
    fi

    echo "$body"
}

# Get current playing info from Navidrome
NOW_PLAYING_JSON=$(navidrome_api_call "getNowPlaying")

if [ $? -ne 0 ] || [ -z "$NOW_PLAYING_JSON" ]; then
    # Server not accessible or error
    sketchybar --set "$NAME" label="" icon="" drawing=off
    exit 0
fi

# Parse the response based on available tools
if [ "$HAS_JQ" = "true" ]; then
    # Use jq for accurate JSON parsing
    # Check if there's a currently playing entry
    ENTRIES=$(echo "$NOW_PLAYING_JSON" | jq -r '.["subsonic-response"].nowPlaying.entry[]? // empty')

    if [ -n "$ENTRIES" ]; then
        # Get the most recent entry (first one)
        ENTRY=$(echo "$NOW_PLAYING_JSON" | jq -r '.["subsonic-response"].nowPlaying.entry[0] // empty')
        TRACK=$(echo "$ENTRY" | jq -r '.title // empty')
        ARTIST=$(echo "$ENTRY" | jq -r '.artist // empty')
        ALBUM=$(echo "$ENTRY" | jq -r '.album // empty')
        MINUTES_AGO=$(echo "$ENTRY" | jq -r '.minutesAgo // 99')

        # Check if it's actually playing (minutesAgo < 3 means it's recent)
        if [ "$MINUTES_AGO" -lt 6 ]; then
            IS_PLAYING="true"
        else
            IS_PLAYING="false"
        fi
    fi
else
    # Fallback to text processing
    TRACK=$(echo "$NOW_PLAYING_JSON" | grep -o '"title":"[^"]*"' | head -1 | cut -d'"' -f4)
    ARTIST=$(echo "$NOW_PLAYING_JSON" | grep -o '"artist":"[^"]*"' | head -1 | cut -d'"' -f4)
    MINUTES_AGO=$(echo "$NOW_PLAYING_JSON" | grep -o '"minutesAgo":[0-9]*' | head -1 | cut -d':' -f2)

    if [ -n "$MINUTES_AGO" ] && [ "$MINUTES_AGO" -lt 3 ]; then
        IS_PLAYING="true"
    else
        IS_PLAYING="false"
    fi
fi

# Format the display
if [ "$IS_PLAYING" = "true" ] && [ -n "$TRACK" ]; then
    # Build the label
    LABEL="$TRACK"
    [ -n "$ARTIST" ] && LABEL="$LABEL - $ARTIST"

    sketchybar --set "$NAME" label="$LABEL" icon="󰎈" drawing=on
else
    # Nothing playing recently
    sketchybar --set "$NAME" label="" icon="" drawing=off
fi
