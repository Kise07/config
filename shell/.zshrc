# ============================================
# ZSH Configuration
# ============================================

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Custom scripts
export PATH="$HOME/.scripts:$PATH"

# ============================================
# HISTORY CONFIGURATION
# ============================================

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_VERIFY

# ============================================
# SHELL OPTIONS
# ============================================

setopt AUTO_CD              # Type directory name to cd
setopt AUTO_PUSHD           # Push directories onto stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicate directories
setopt PUSHD_SILENT         # Don't print directory stack
setopt CORRECT              # Command correction suggestions
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shell
unsetopt BEEP               # No terminal beep

# ============================================
# PROMPT - Starship
# ============================================

if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# ============================================
# PLUGINS - Oh My Zsh
# ============================================

plugins=(
    git
    fzf
    zoxide
    fzf-tab
    zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

# ============================================
# SYNTAX HIGHLIGHTING
# ============================================

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES=(
  command "fg=green,bold"
  alias "fg=green,bold"
  builtin "fg=cyan"
  function "fg=cyan"
  keyword "fg=red,bold"
  reserved-word "fg=red,bold"
  hashed-command "fg=green"
  path "fg=white"
  globbing "fg=yellow"
  history-expansion "fg=blue"
  single-quoted-argument "fg=yellow"
  double-quoted-argument "fg=yellow"
  dollar-quoted-argument "fg=yellow"
  rc-quote "fg=magenta"
  back-quoted-argument "fg=magenta"
  default "fg=white"
)

# ============================================
# NVM - Lazy Loading
# ============================================

export NVM_DIR="$HOME/.nvm"

if [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
    _nvm() {
        unset -f nvm node npm npx nvm
        source "/opt/homebrew/opt/nvm/nvm.sh"
        [[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]] && \
            source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    }
    nvm() { _nvm; nvm "$@"; }
    node() { _nvm; node "$@"; }
    npm() { _nvm; npm "$@"; }
    npx() { _nvm; npx "$@"; }
fi

# ============================================
# BUN
# ============================================

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

if [[ -s "$BUN_INSTALL/_bun" ]]; then
    source "$BUN_INSTALL/_bun"
fi

# ============================================
# PATH CONFIGURATION
# ============================================

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export EDITOR="nvim"

# ============================================
# FZF - Fuzzy Finder
# ============================================

source <(fzf --zsh)
source ~/fzf-git.sh/fzf-git.sh

# Ctrl+F for file picker, disable Ctrl+T
bindkey '^F' fzf-file-widget
bindkey -r '^T'

# Ctrl+G for directory jumping
bindkey '^G' fzf-cd-widget

# FZF preview with eza + bat
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# FZF completion customization
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

# ============================================
# FZF-TAB Configuration
# ============================================

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --icons $realpath 2>/dev/null || ls --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always --icons $realpath 2>/dev/null || ls --color=always $realpath'

# ============================================
# HISTORY SUBSTRING SEARCH Keybindings
# ============================================

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ============================================
# ALIASES - General
# ============================================

alias c='clear'
alias cls='clear'
alias vim=nvim
alias reload='source ~/.zshrc && echo "✓ ZSH configuration reloaded"'
alias zshrc='${EDITOR:-nvim} ~/.zshrc'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# System
alias ports='netstat -tulanp'
alias update='brew update && brew upgrade'

# Git shortcuts
alias g='git'
alias gst='git status'
alias gco='git checkout'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --graph --decorate'

# ============================================
# ALIASES - Eza (ls replacement)
# ============================================

if command -v eza &>/dev/null; then
    alias ls='eza --icons'
    alias ll='eza -la --icons --git'
    alias lt='eza --tree --icons --level=2'
    alias lta='eza --tree --icons --level=3 --all'
fi

# ============================================
# ALIASES - Bun
# ============================================

if command -v bun &>/dev/null; then
    alias bro='bun run dev'
    alias bro-cook='bun run build'
    alias bi='bun install'
    alias ba='bun add'
    alias br='bun remove'
fi

# Opencode shortcut
alias oc="opencode"

# ============================================
# TMUX - Session management
# ============================================

alias t='tmux'
alias tn='tmux new-session -s'
alias ta='tmux attach'
alias tls='tmux list-sessions'
alias ts='tmux switch-client -t'
alias tk='tmux kill-session -t'
alias tka='tmux kill-server'
alias tr='tmux rename-session -t'
alias td='tmux detach-client'

# ============================================
# ZOXIDE - Smart cd
# ============================================

eval "$(zoxide init --cmd cd zsh)"

# ============================================
# YAZI - File Manager
# ============================================

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# ============================================
# POWERLEVEL10K Instant Prompt
# ============================================

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================
# REMAINING DAYS - Quote + Countdown
# ============================================

remaining_days() {
    local CUSTOM_DATE=$1

    # Validate date format
    if [[ ! $CUSTOM_DATE =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "Error: Invalid date format. Use YYYY-MM-DD" >&2
        return 1
    fi

    # Calculate days remaining
    local TODAY=$(date +%s)
    local TARGET

    # Portable date parsing (macOS/BSD vs GNU)
    if date --version >/dev/null 2>&1; then
        TARGET=$(date -d "$CUSTOM_DATE" +%s 2>/dev/null)
    else
        TARGET=$(date -j -f "%Y-%m-%d" "$CUSTOM_DATE" +%s 2>/dev/null)
    fi

    if [[ -z "$TARGET" ]]; then
        echo "Error: Invalid date '$CUSTOM_DATE'" >&2
        return 1
    fi

    local SECONDS_REMAINING=$(( TARGET - TODAY ))
    local DAYS_REMAINING=$(( SECONDS_REMAINING / 86400 ))

    local PRETTY_DATE
    if date --version >/dev/null 2>&1; then
        PRETTY_DATE=$(date -d "$CUSTOM_DATE" "+%A, %B %d, %Y")
    else
        PRETTY_DATE=$(date -j -f "%Y-%m-%d" "$CUSTOM_DATE" "+%A, %B %d, %Y")
    fi

    if (( DAYS_REMAINING < 0 )); then
        DAYS_REMAINING=0
    fi

    local ITALIC_CYAN='\e[1;3;96m'
    local ITALIC_YELLOW='\e[1;3;93m'
    local ITALIC_RED='\e[1;3;91m'
    local RESET='\e[0m'

    # <== EDIT YOUR QUOTE HERE ==>
printf "${ITALIC_CYAN}\t\"Everything ends, end is ...prepare\"\n"
    printf "${ITALIC_YELLOW}\t— kise\n${RESET}\n"
    printf "${ITALIC_RED}\t%d days --> '%s'${RESET}\n" "$DAYS_REMAINING" "$PRETTY_DATE"
}

# ============================================
# FASTFETCH - System Info on Startup
# ============================================

if [[ -t 1 ]]; then
    fastfetch
    remaining_days "2026-12-31"
    echo ""
fi

# ============================================
# LOCAL CONFIGURATION
# ============================================

LOCAL_ZSHRC="$HOME/.zshrc.local"
if [[ -f "$LOCAL_ZSHRC" ]]; then
    source "$LOCAL_ZSHRC"
fi
