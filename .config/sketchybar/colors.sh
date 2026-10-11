#!/usr/bin/env bash
# Colours for sketchybarrc and plugins, from the active theme (~/dotfiles/bin/theme).
# Falls back to Catppuccin Mocha when no theme is set.

THEME_COLORS="$HOME/.local/state/theme/current/sketchybar.sh"
if [ -f "$THEME_COLORS" ]; then
  . "$THEME_COLORS"
else
  . "$HOME/dotfiles/themes/catppuccin-mocha/sketchybar.sh"
fi
