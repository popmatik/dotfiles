# Dotfiles

Personal configuration files for macOS.

## What's Included

- **zsh** - `.zshrc` (oh-my-zsh, fzf, starship); API keys live in `~/.zshrc.secrets`, never committed
- **ghostty** - Terminal
- **herdr** - `config.toml` only (herdr keeps sockets and logs beside it)
- **nvim** - Neovim configuration
- **sketchybar** - Custom macOS menu bar
- **skhd** - Hotkey daemon
- **tmux** - Terminal multiplexer
- **tmuxinator** - Tmux session manager
- **yabai** - Tiling window manager (with JankyBorders)
- **starship** - Cross-shell prompt
- **git** - `.gitconfig` (delta, catppuccin), `.ripgreprc`
- **Brewfile** - everything Homebrew installs
- **bin/theme** - theme switcher (below)

## New Mac

```bash
git clone git@github.com:popmatik/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` installs Homebrew and the Brewfile, oh-my-zsh, fzf-git.sh, catppuccin/delta and tpm,
links every config into place, creates an empty `~/.zshrc.secrets`, applies a theme and fetches
wallpapers, installs tmux and nvim plugins, and starts sketchybar, yabai and skhd. It's safe to
re-run; anything already in the way is moved aside to `<name>.backup.<timestamp>`. Use
`--skip-brew` to skip Homebrew.

It finishes with the steps that can't be scripted: filling in `~/.zshrc.secrets`, linking the
herdr plugin, macOS Accessibility permissions for yabai and skhd, and yabai's scripting addition (needs
SIP partly disabled).

To refresh the Brewfile after installing things:

```bash
brew bundle dump --file ~/dotfiles/Brewfile --force
```

That drops the hand-added block at the bottom (taps `brew bundle dump` misses), so re-add it.

## Themes

`theme` switches colours everywhere at once; run it with no arguments for an fzf picker, or
`theme <name>`. Themes are folders in `themes/`, each with:

- `ghostty.conf` - included by `.config/ghostty/config`; herdr uses the terminal palette, so it follows
- `tmux.conf` - `@thm_*` colours, sourced before the catppuccin tmux plugin
- `nvim.lua` - colorscheme, lualine theme and highlight overrides; running nvims re-apply on `SIGUSR1`
- `starship.toml` - a `[palettes.theme]` block appended to `.config/starship.toml`
- `sketchybar.sh` - bar colours, loaded by `.config/sketchybar/colors.sh` (bar reloads on switch)
- `borders` - JankyBorders colours, used by yabairc and pushed to the running instance

- `backgrounds/` - wallpapers (gitignored). `theme --fetch-backgrounds` downloads Omarchy's,
  minus the Omarchy-branded ones; `theme --next-bg` cycles them and each theme remembers its pick.
  It's set on every Space by writing macOS's wallpaper store
  (`~/Library/Application Support/com.apple.wallpaper/Store/Index.plist`) and restarting
  WallpaperAgent, since AppleScript only reaches the current Space.

The active theme is the symlink `~/.local/state/theme/current`. To add a theme, copy a folder
and change the colours.

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

2. Create a symlink, and add the same `link` line to `install.sh`:
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
