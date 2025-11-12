#!/bin/bash

RED=0xfff38ba8
GREEN=0xffa6e3a1

# Check ProtonVPN connection status via scutil
if scutil --nc list | grep "ProtonVPN" | grep -q "Connected"; then
    sketchybar --set $NAME icon="󰌾" label="VPN" icon.color=$GREEN
else
    sketchybar --set $NAME icon="󰌾" label="VPN" icon.color=$RED
fi
