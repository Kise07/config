# 🚀 Dotfiles - Multi-System Configuration

Modular dotfiles setup using **GNU Stow** for easy management across multiple systems.

## 📋 What's Inside?

| Module | Contains | Symlink Target |
|--------|----------|---|
| **shell/** | `.zshrc`, `.bashrc`, `.zprofile`, `.p10k.zsh` | `~/` |
| **tmux/** | `.config/tmux/` (configs + TPM plugins) | `~/.config/tmux/` |
| **nvim/** | `.config/nvim/` (Neovim configs) | `~/.config/nvim/` |
| **ghostty/** | `.config/ghostty/config` | `~/.config/ghostty/` |
| **scripts/** | `.scripts/` (custom scripts) | `~/.scripts/` |
| **git/** | `.gitconfig` | `~/` |

## 🎯 Features

✅ **Syntax Highlighting** - zsh-syntax-highlighting configured  
✅ **Prompt Theme** - p10k (Powerlevel10k) with custom colors  
✅ **Terminal Colors** - Consistent across normal shell and tmux  
✅ **Tmux Plugins** - TPM with Catppuccin theme + sessionx  
✅ **Neovim Setup** - Full LSP + Treesitter + plugins  
✅ **Custom Scripts** - Utility scripts in `~/.scripts/`  
✅ **Git Config** - Global gitconfig with aliases  
✅ **Terminal Emulator** - Ghostty configuration  

## 🛠️ Installation

### 1️⃣ Prerequisites

```bash
# Install Homebrew packages
brew install stow zsh tmux neovim ghostty

# Install syntax highlighting
brew install zsh-syntax-highlighting

# Install other tools
brew install fzf ripgrep bat eza yazi lazygit
```

### 2️⃣ Clone & Deploy

```bash
# Clone repository
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Deploy all modules with Stow
stow shell tmux nvim ghostty scripts git

# Or deploy specific modules
stow shell          # Just shell configs
stow tmux           # Just tmux
```

### 3️⃣ Verify Installation

```bash
# Check symlinks were created
ls -la ~/ | grep "^l"    # Should see .zshrc, .bashrc -> dotfiles
ls -la ~/.config/tmux/   # Should see .config/tmux/tmux.conf (symlink)

# Test shell
source ~/.zshrc
echo $SHELL
```

## 📁 Directory Structure

```
~/dotfiles/
├── .git/              # Git repository metadata
├── .gitignore         # Ignore tmux plugins
├── .stowrc           # Stow configuration
├── README.md         # This file
├── shell/
│   ├── .bashrc
│   ├── .zshrc
│   ├── .zprofile
│   └── .p10k.zsh
├── tmux/
│   └── .config/tmux/
│       ├── tmux.conf
│       ├── utility.conf
│       ├── macos.conf
│       ├── statusline.conf
│       └── plugins/    # (gitignored - TPM managed)
├── nvim/
│   └── .config/nvim/
│       ├── init.lua
│       ├── lazy-lock.json
│       └── lua/...
├── ghostty/
│   └── .config/ghostty/
│       └── config
├── scripts/
│   └── .scripts/
│       ├── ide
│       └── nl
└── git/
    └── .gitconfig
```

## 🔄 How Stow Works

**Stow creates symlinks** from `~/dotfiles/<module>/` to your `~/$HOME`:

```bash
stow shell
# Creates: ~/.zshrc → ~/dotfiles/shell/.zshrc (symlink)
# Creates: ~/.p10k.zsh → ~/dotfiles/shell/.p10k.zsh (symlink)
```

**Benefits:**
- ✅ Single source of truth
- ✅ Edit configs anywhere, changes sync
- ✅ Easy version control with Git
- ✅ Simple to add/remove modules
- ✅ Portable across systems

## 🎨 Customization

### System-Specific Configs

Create `.local` files (git-ignored) for system-specific settings:

```bash
# Shell
echo 'export MY_CUSTOM_VAR=value' > ~/.zshrc.local

# Tmux
echo 'set -g mouse on' > ~/.config/tmux/tmux.local

# Git
echo '[user]\n    name = Your Name' > ~/.gitconfig.local
```

Add to `.gitignore`:
```
**/.local
**/*.local
```

## 🚫 Removing Stow

To unlink a module:

```bash
stow -D shell      # Unstow shell module
stow -D tmux nvim  # Unstow multiple modules
```

## 📝 Color Scheme

- **Shell Theme**: `alanpeabody` (bright white brackets)
- **Prompt**: `powerlevel10k` with custom styling
- **Syntax Highlighting**: zsh-syntax-highlighting (terminal-compatible)
- **Tmux Theme**: Catppuccin Mocha
- **Terminal Colors**: `tmux-256color` with true color support

## 🔧 Troubleshooting

### Symlinks not created?
```bash
# Check current stow status
stow --simulate shell

# Stow with verbose output
stow --verbose=2 shell
```

### Conflicting files?
```bash
# Backup existing config
mv ~/.zshrc ~/.zshrc.backup

# Try stow again
stow shell
```

### Oh My Zsh conflicts?
If using Oh My Zsh, source after `.zshrc`:
```bash
# ~/.zshrc sourcing order matters!
source ~/.config/zsh/config.zsh  # Your configs
source ~/.oh-my-zsh/oh-my-zsh.sh # OMZ last
```

## 📚 References

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/)
- [Powerlevel10k Docs](https://github.com/romkatv/powerlevel10k)
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
- [Neovim](https://neovim.io/)
- [Ghostty](https://ghostty.org/)

## 🤝 Contributing

Feel free to fork and adapt these configs to your workflow!

---

**Last Updated**: 2026-06-07  
**Tested On**: macOS (Sonoma)  
**Shell**: Zsh  
**Terminal**: Ghostty
