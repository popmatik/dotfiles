# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim -w'
 else
   export EDITOR='nvim -w'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export RIPGREP_CONFIG_PATH=~/.ripgreprc
eval "$(starship init zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# ---- Eza (better ls) -----

alias ls="eza --color=always --grid --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
eval "$(fzf --zsh)"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}
# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# thefuck alias
if command -v thefuck >/dev/null; then
  eval $(thefuck --alias)
  eval $(thefuck --alias fk)
fi
[ -f ~/fzf-git.sh/fzf-git.sh ] && source ~/fzf-git.sh/fzf-git.sh
alias gitlast="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | head -n 30"
alias conflict="git grep -l '<<<<<<< HEAD'"

[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"
# API keys live in ~/.zshrc.secrets, which is never committed.
[ -f "$HOME/.zshrc.secrets" ] && source "$HOME/.zshrc.secrets"

# General theme mode
export AIDER_COLOR_THEME="dark"

# Aider AI Color Theme - Catppuccin Mocha Dark

# Set user input color to Catppuccin green (instead of default #00cc00)
export AIDER_USER_INPUT_COLOR="#A6E3A1"

# Set tool output color to Catppuccin sky
export AIDER_TOOL_OUTPUT_COLOR="#89DCEB"

# Set tool error color to Catppuccin red (replacing default #FF2222)
export AIDER_TOOL_ERROR_COLOR="#F38BA8"

# Set tool warning color to Catppuccin yellow (replacing default #FFA500)
export AIDER_TOOL_WARNING_COLOR="#F9E2AF"

# Set assistant output color to Catppuccin blue (instead of default #0088ff)
export AIDER_ASSISTANT_OUTPUT_COLOR="#89B4FA"

# Completion menu colors based on Catppuccin Mocha palette:
# - Text color for the menu (using the Catppuccin text color)
export AIDER_COMPLETION_MENU_COLOR="#CDD6F4"
# - Background color for the menu (using the Catppuccin base color)
export AIDER_COMPLETION_MENU_BG_COLOR="#1E1E2E"
# - Current item text color (set to the base so that it contrasts with the current background)
export AIDER_COMPLETION_MENU_CURRENT_COLOR="#1E1E2E"
# - Current item background color (using the Catppuccin peach accent)
export AIDER_COMPLETION_MENU_CURRENT_BG_COLOR="#FAB387"
export AIDER_CODE_THEME="catppuccin-mocha"
# Vim motions in fzf
export FZF_DEFAULT_OPTS="
--bind 'esc:ignore'
  --bind 'j:down'
  --bind 'k:up'
  --bind 'ctrl-j:down'
  --bind 'ctrl-k:up'
"
export COLORTERM=truecolor


# Task Master aliases added on 25/04/2025
alias tm='task-master'
alias taskmaster='task-master'

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$PATH:$HOME/.spicetify"
# Pi-hole DNS toggle
alias dns-block='networksetup -setdnsservers "USB 10/100/1G/2.5G LAN" 192.168.0.34 && networksetup -setdnsservers Wi-Fi 192.168.0.34'
alias dns-normal='networksetup -setdnsservers "USB 10/100/1G/2.5G LAN" 1.1.1.1 && networksetup -setdnsservers Wi-Fi 1.1.1.1'
alias dns-check='echo "Ethernet:" && networksetup -getdnsservers "USB 10/100/1G/2.5G LAN" && echo "Wi-Fi:" && networksetup -getdnsservers Wi-Fi'

export PATH="$PATH:$HOME/.local/bin"

# theme switcher and other dotfiles scripts
export PATH="$HOME/dotfiles/bin:$PATH"
