# Dotfiles

Personal configuration files for macOS.

## What's Included

- **nvim** - Neovim configuration
- **sketchybar** - Custom macOS menu bar
- **skhd** - Hotkey daemon
- **tmux** - Terminal multiplexer
- **tmuxinator** - Tmux session manager
- **yabai** - Tiling window manager
- **starship** - Cross-shell prompt

## Installation

### Prerequisites

- macOS
- Git

### Quick Setup

1. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
```

2. Create symlinks:
```bash
# Config files in ~/.config/
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
ln -s ~/dotfiles/.config/sketchybar ~/.config/sketchybar
ln -s ~/dotfiles/.config/skhd ~/.config/skhd
ln -s ~/dotfiles/.config/tmux ~/.config/tmux
ln -s ~/dotfiles/.config/tmuxinator ~/.config/tmuxinator
ln -s ~/dotfiles/.config/yabai ~/.config/yabai
ln -s ~/dotfiles/.config/starship.toml ~/.config/starship.toml

# Config files in ~/
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
```

3. Restart relevant services as needed.

## How It Works

This dotfiles setup uses **symlinks**:
- The actual config files live in `~/dotfiles/.config/`
- Symlinks point from `~/.config/` to the dotfiles repo
- Changes to configs are automatically tracked by git
- No need to copy files back and forth

## Adding New Configs

To add another config:

1. Move it to dotfiles:
```bash
mv ~/.config/CONFIGNAME ~/dotfiles/.config/CONFIGNAME
```

2. Create a symlink:
```bash
ln -s ~/dotfiles/.config/CONFIGNAME ~/.config/CONFIGNAME
```

3. Commit to git:
```bash
cd ~/dotfiles
git add .config/CONFIGNAME
git commit -m "Add CONFIGNAME config"
git push
```

## License

Free to use and modify.
