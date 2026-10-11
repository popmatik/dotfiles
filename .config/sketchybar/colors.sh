#!/usr/bin/env bash
# Colours for sketchybarrc and plugins, from the active theme (~/dotfiles/bin/theme).
# Falls back to Catppuccin Mocha when no theme is set.

THEME_COLORS="$HOME/.local/state/theme/current/sketchybar.sh"
if [ -f "$THEME_COLORS" ]; then
  . "$THEME_COLORS"
else
  # CONFIG_DIR links into the dotfiles repo; its themes/ sits two levels up.
  . "$(cd "$CONFIG_DIR" && pwd -P)/../../themes/catppuccin-mocha/sketchybar.sh"
fi
