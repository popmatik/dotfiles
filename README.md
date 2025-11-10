# Dotfiles

My personal configuration files for macOS.

## What's Included

- **SketchyBar**: Custom macOS menu bar with Catppuccin Mocha theme
  - Spotify integration showing currently playing track
  - Custom workspace icons
  - Animated workspace switching
  - Clock, volume, and battery indicators

## Installation

### Prerequisites

- macOS
- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- Git

### Setup

1. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
```

2. Create symlinks for the configs you want to use:

```bash
# SketchyBar
ln -s ~/dotfiles/.config/sketchybar ~/.config/sketchybar
```

3. Restart the relevant services:

```bash
# SketchyBar
brew services restart sketchybar
```

## SketchyBar Configuration

### Features
- Transparent bar with blur effect
- Catppuccin Mocha color scheme
- Custom space icons for different workflows (Code, Web, Chat, Music, Mixing)
- Animated workspace transitions
- Real-time Spotify track display
- System indicators: clock, volume, battery

### Customization

To change space icons, edit the `SPACE_ICONS` array in `.config/sketchybar/sketchybarrc`:

```bash
SPACE_ICONS=("" "" "󰭹" "󰝚" "" "6" "7" "8" "9" "10")
```

Find more icons at [Nerd Fonts Cheat Sheet](https://www.nerdfonts.com/cheat-sheet).

### Colors

The configuration uses Catppuccin Mocha colors defined at the top of `sketchybarrc`.
Active workspace color is set in `.config/sketchybar/plugins/space.sh`.

## Adding More Configs

To add another config (e.g., nvim):

1. Move the config to dotfiles:
```bash
mv ~/.config/nvim ~/dotfiles/.config/nvim
```

2. Create a symlink:
```bash
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
```

3. Add and commit to git:
```bash
cd ~/dotfiles
git add .config/nvim
git commit -m "Add nvim config"
```

## License

Feel free to use and modify these configs for your own setup!
