############################################
# ZSH – Portable config (macOS + Linux)
############################################

# ---------- Basic paths ----------
export PATH="$HOME/.scripts:$HOME/.local/bin:$PATH"

# ---------- Oh My Zsh ----------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)

source "$ZSH/oh-my-zsh.sh"

# ---------- NVM (macOS + Linux) ----------
export NVM_DIR="$HOME/.nvm"

# Linux (apt / manual)
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# macOS (Homebrew)
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \
  source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# ---------- Deno ----------
if [ -f "$HOME/.deno/env" ]; then
  source "$HOME/.deno/env"
fi

# ---------- Aliases ----------
alias vim=nvim
alias g="git"
alias cd="z"

alias la="ls -A"
alias ll="ls -l"
alias lla="ll -A"

# Better ls (eza if available)
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --color=always --long --git --icons=always --no-time"
else
  alias ls="ls --color=auto"
fi

# ---------- Zoxide ----------
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ---------- FZF ----------
# Load fzf keybindings + completion
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Use fd if available
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
fi

# Preview options
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Use Ctrl-F instead of Ctrl-T
bindkey '^F' fzf-file-widget
bindkey -r '^T'

# FZF completion helpers
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)    fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    ssh)   fzf --preview 'dig {}' "$@" ;;
    *)     fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# ---------- fzf-git ----------
if [ -f "$HOME/fzf-git.sh/fzf-git.sh" ]; then
  source "$HOME/fzf-git.sh/fzf-git.sh"
fi

# ---------- Bat ----------
# Uncomment if you want a default theme
# export BAT_THEME="Solarized Dark"

# ---------- Homebrew (macOS only) ----------
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

# ---------- Pipx ----------
export PATH="$PATH:$HOME/.local/bin"

# ---------- Powerlevel10k ----------
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

