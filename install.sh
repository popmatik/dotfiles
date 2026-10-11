#!/usr/bin/env bash
# install.sh — set up a Mac from these dotfiles. Safe to re-run: existing links are left alone and
# anything else in the way is moved aside to <name>.backup.<timestamp>.
#
#   ./install.sh               everything
#   ./install.sh --skip-brew   skip Homebrew and the Brewfile

set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
SKIP_BREW=false
[[ ${1:-} == --skip-brew ]] && SKIP_BREW=true

step() { printf '\n==> %s\n' "$*"; }

# link <path in repo> <destination>
link() {
  link_abs "$DOTFILES/$1" "$2"
}

# link_abs <absolute source> <destination>
link_abs() {
  local src="$1" dest="$2"
  [[ -L $dest && $(readlink "$dest") == "$src" ]] && return
  if [[ -e $dest || -L $dest ]]; then
    mv "$dest" "$dest.backup.$(date +%Y%m%d%H%M%S)"
    echo "  moved existing $dest aside"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "  linked $dest"
}

# clone <url> <destination>
clone() {
  [[ -d $2 ]] && return
  git clone -q --depth 1 "$1" "$2"
  echo "  cloned $2"
}

if ! $SKIP_BREW; then
  step "Homebrew"
  if ! command -v brew >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  # Apple Silicon, then Intel.
  for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x $brew_bin ]] && { eval "$("$brew_bin" shellenv)"; break; }
  done
  brew bundle install --no-upgrade --file "$DOTFILES/Brewfile" ||
    echo "  some Brewfile entries failed; see above (re-run once fixed)"
fi

step "Shell"
if [[ ! -d $HOME/.oh-my-zsh ]]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
clone https://github.com/junegunn/fzf-git.sh "$HOME/fzf-git.sh"
clone https://github.com/catppuccin/delta "$HOME/delta"
clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

step "Links"
link .zshrc "$HOME/.zshrc"
link .tmux.conf "$HOME/.tmux.conf"
link .gitconfig "$HOME/.gitconfig"
link .ripgreprc "$HOME/.ripgreprc"
for dir in ghostty nvim sketchybar skhd tmux tmuxinator yabai; do
  link ".config/$dir" "$HOME/.config/$dir"
done
# herdr keeps sockets and logs beside its config, so only the file is linked.
link .config/herdr/config.toml "$HOME/.config/herdr/config.toml"

step "Secrets"
if [[ ! -f $HOME/.zshrc.secrets ]]; then
  (umask 077 && cat >"$HOME/.zshrc.secrets" <<'EOF'
# API keys - never committed. Sourced by ~/.zshrc.
# export ANTHROPIC_API_KEY=
# export TAVILY_API_KEY=
# export OPENROUTER_API_KEY=
EOF
  )
  echo "  created ~/.zshrc.secrets - fill in your keys"
else
  echo "  ~/.zshrc.secrets already exists"
fi

step "Theme"
if [[ ! -L $HOME/.local/state/theme/current ]]; then
  "$DOTFILES/bin/theme" catppuccin-mocha
fi
# starship reads the config `theme` generates.
link_abs "$HOME/.local/state/theme/starship.toml" "$HOME/.config/starship.toml"
if ! find "$DOTFILES/themes" -path '*/backgrounds/*' -type f -print -quit | grep -q .; then
  "$DOTFILES/bin/theme" --fetch-backgrounds
fi

step "Plugins"
"$HOME/.tmux/plugins/tpm/bin/install_plugins" >/dev/null && echo "  tmux plugins installed"
if command -v nvim >/dev/null; then
  nvim --headless "+Lazy! restore" +qa >/dev/null 2>&1 && echo "  nvim plugins restored from lazy-lock.json"
fi

step "Services"
command -v sketchybar >/dev/null && { brew services start sketchybar >/dev/null 2>&1 || true; }
command -v yabai >/dev/null && { yabai --start-service 2>/dev/null || true; }
command -v skhd >/dev/null && { skhd --start-service 2>/dev/null || true; }
echo "  sketchybar, yabai and skhd started (borders is started by yabairc)"

cat <<'EOF'

Done. Still to do by hand:
  - Fill in ~/.zshrc.secrets (keep a copy somewhere safe, such as 1Password).
  - Link the herdr plugin: herdr plugin link ~/.claude/herdr-plugins/worktree-setup
  - Grant Accessibility to yabai and skhd (System Settings > Privacy & Security > Accessibility).
  - yabai's scripting addition (used to focus Spaces) needs SIP partly disabled; see the yabai wiki.
  - Allow your terminal to control Ghostty the first time `theme` asks.
  - Open a new terminal to pick up the shell config.
EOF
