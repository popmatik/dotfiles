#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Check ProtonVPN connection status via scutil
if scutil --nc list | grep "ProtonVPN" | grep -q "Connected"; then
    sketchybar --set $NAME icon="󱎚" label="VPN" icon.color=$GREEN
else
    sketchybar --set $NAME icon="󱚩" label="VPN" icon.color=$RED
fi
