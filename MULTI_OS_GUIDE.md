═══════════════════════════════════════════════════════════════════
  🖥️  MULTI-OS DOTFILES BRANCH STRUCTURE - COMPLETE GUIDE
═══════════════════════════════════════════════════════════════════

📍 THREE BRANCHES AVAILABLE:

main  ✨  Base/Universal configs (shared by all OS)
  ↓
macos 🍎  macOS-specific branch
linux 🐧  Linux-specific branch

═══════════════════════════════════════════════════════════════════

🎯 BRANCH STRUCTURE & PURPOSE:

MAIN BRANCH (Universal Base)
────────────────────────────────────────────────────────────────

Contents:
  git/              ✅ Works on all OS
  nvim/             ✅ Works on all OS
  scripts/          ✅ Works on all OS (with OS detection)
  tmux/             ✅ Core config works on all OS
  README.md         ✅ General documentation
  setup.sh          ✅ Universal setup script
  .gitignore        ✅ Works on all OS
  .stowrc           ✅ Works on all OS

Purpose:
  • Base configurations that work everywhere
  • Universal tools (git, nvim, tmux core)
  • Default setup before OS-specific customization

When to use main:
  • Initial clone
  • When setting up a new OS for the first time
  • To see what's available


MACOS BRANCH (🍎 Apple Specific)
────────────────────────────────────────────────────────────────

What's ADDED/MODIFIED:
  shell/            ✅ .zshrc with macOS Homebrew paths
                       (/opt/homebrew/bin)
  
  tmux/             ✅ macos.conf with:
                       - macOS copy/paste commands
                       - macOS-specific keybindings
                       - native pbcopy/pbpaste
  
  ghostty/          ✅ Ghostty terminal emulator config
                       (macOS ONLY - not available on Linux)

What's INHERITED from main:
  git/              ✅ Same as main
  nvim/             ✅ Same as main
  scripts/          ✅ Same as main

Special Features on macOS branch:
  • Ghostty terminal integration
  • Homebrew at /opt/homebrew (Apple Silicon) or /usr/local (Intel)
  • Native macOS command integration (open, pbcopy, pbpaste)
  • Optimized for macOS key commands (Cmd instead of Ctrl)

Usage:
  ```bash
  git clone <repo> ~/dotfiles
  cd ~/dotfiles
  git checkout macos              # Switch to macOS branch
  stow shell tmux nvim ghostty git scripts
  source ~/.zshrc
  ```


LINUX BRANCH (🐧 Linux Specific)
────────────────────────────────────────────────────────────────

What's ADDED/MODIFIED:
  shell/            ✅ .zshrc with Linux Homebrew paths
                       (if using Linuxbrew) or ~/.local/bin
  
  wezterm/          ✅ WezTerm terminal emulator config
                       (Linux/cross-platform alternative to Ghostty)
  
  tmux/             ✅ linux.conf with:
                       - xclip for clipboard (or xsel)
                       - Linux-specific keybindings
                       - xdg-open for opening files/URLs
                       - Linux terminal compatibility

What's INHERITED from main:
  git/              ✅ Same as main
  nvim/             ✅ Same as main
  scripts/          ✅ Same as main

What's REMOVED:
  ghostty/          ❌ Not available on Linux

Special Features on Linux branch:
  • WezTerm terminal (works on Linux, macOS, Windows)
  • xclip integration for system clipboard
  • Linux-specific command handling (xdg-open instead of open)
  • Compatible with most Linux distributions

Usage:
  ```bash
  git clone <repo> ~/dotfiles
  cd ~/dotfiles
  git checkout linux              # Switch to Linux branch
  stow shell tmux nvim wezterm git scripts
  source ~/.zshrc
  ```

═══════════════════════════════════════════════════════════════════

📊 WHAT'S DIFFERENT BETWEEN BRANCHES:

Feature               main        macos         linux
─────────────────────────────────────────────────────────────────
Shell Paths           ⚠️ Generic   ✅ Optimized   ✅ Optimized
Homebrew Support      ❌ None      ✅ Yes         ⚠️ Linuxbrew
Terminal Emulator     ❌ None      ✅ Ghostty     ✅ WezTerm
Clipboard (xclip)     ❌ No        ❌ No          ✅ Yes
macOS Commands        ❌ No        ✅ Yes         ❌ No
Linux Commands        ❌ No        ❌ No          ✅ Yes
Nvim Integration      ✅ Same      ✅ Same        ✅ Same
Git Config            ✅ Same      ✅ Same        ✅ Same
Scripts               ✅ Base      ✅ Plus macOS  ✅ Plus Linux

═══════════════════════════════════════════════════════════════════

📁 FILE STRUCTURE BY BRANCH:

MAIN BRANCH:
  dotfiles/
  ├── git/           # Git config (all OS)
  ├── nvim/          # Neovim (all OS)
  ├── scripts/       # Scripts (all OS)
  ├── tmux/          # Core tmux (all OS)
  │   └── .config/tmux/
  │       ├── tmux.conf       ← Sources macos.conf OR linux.conf
  │       ├── macos.conf      ← macOS-specific (stub on main)
  │       ├── linux.conf      ← Linux-specific (stub on main)
  │       ├── utility.conf
  │       ├── statusline.conf
  │       └── plugins/
  ├── shell/         # Shell (generic on main)
  │   └── .zshrc     ← Generic $PATH
  ├── README.md
  └── setup.sh

MACOS BRANCH (inherits + modifies):
  dotfiles/
  ├── git/           ✅ [Inherited from main]
  ├── nvim/          ✅ [Inherited from main]
  ├── scripts/       ✅ [Inherited from main]
  ├── tmux/          ✅ [Inherited from main]
  │   └── .config/tmux/
  │       ├── macos.conf      ← FULLY CONFIGURED for macOS
  │       └── ...
  ├── shell/         ✅ MODIFIED
  │   └── .zshrc     ← WITH /opt/homebrew/bin
  ├── ghostty/       ➕ NEW
  │   └── .config/ghostty/
  │       └── config
  └── ...

LINUX BRANCH (inherits + modifies):
  dotfiles/
  ├── git/           ✅ [Inherited from main]
  ├── nvim/          ✅ [Inherited from main]
  ├── scripts/       ✅ [Inherited from main]
  ├── tmux/          ✅ [Inherited from main]
  │   └── .config/tmux/
  │       ├── linux.conf      ← FULLY CONFIGURED for Linux
  │       └── ...
  ├── shell/         ✅ MODIFIED
  │   └── .zshrc     ← WITH ~/.local/bin
  ├── wezterm/       ➕ NEW
  │   └── .config/wezterm/
  │       └── wezterm.lua
  ├── ghostty/       ❌ REMOVED (not available on Linux)
  └── ...

═══════════════════════════════════════════════════════════════════

🚀 HOW TO USE THE BRANCHES:

SETUP MACOS SYSTEM:
  ```bash
  git clone https://github.com/YOUR_USERNAME/dotfiles.git
  cd dotfiles
  git checkout macos
  bash setup.sh
  # Or manually:
  stow shell tmux nvim ghostty git scripts
  source ~/.zshrc
  ```

SETUP LINUX SYSTEM:
  ```bash
  git clone https://github.com/YOUR_USERNAME/dotfiles.git
  cd dotfiles
  git checkout linux
  bash setup.sh
  # Or manually:
  stow shell tmux nvim wezterm git scripts
  source ~/.zshrc
  ```

SWITCH SYSTEMS:
  ```bash
  # Was on macOS, moving to Linux
  git checkout linux
  
  # Unstow macOS-specific
  stow -D ghostty
  
  # Stow Linux-specific
  stow wezterm
  
  # Reload shell
  source ~/.zshrc
  ```

═══════════════════════════════════════════════════════════════════

🎓 WHY THIS STRUCTURE? (Final Explanation)

1. ✅ DRY (Don't Repeat Yourself)
   ──────────────────────────────
   • Common configs in main branch
   • No duplication of git/, nvim/, scripts/
   • Changes to universal configs only in one place
   • macOS/Linux branches inherit base
   
2. ✅ CLEAR SEPARATION
   ─────────────────
   • macOS branch clearly shows macOS-specific stuff
   • Linux branch clearly shows Linux-specific stuff
   • Easy to see what's different
   • New users know which branch to use
   
3. ✅ EASY TO MAINTAIN
   ──────────────────
   • Update universal configs → cherry-pick to both branches
   • Add new OS → create new branch from main
   • No merge conflicts between OS branches (they don't touch same files)
   
4. ✅ GIT HISTORY IS CLEAN
   ──────────────────────
   • main branch shows universal changes only
   • macos branch shows macOS-specific changes only
   • Easy to track what changed and why
   • git log is readable per-branch
   
5. ✅ SCALES WELL
   ────────────
   Add Windows support?
   → Create windows branch from main
   → Add powershell config, Windows Terminal config
   → Done!
   
   Add Raspberry Pi?
   → Create arm-linux branch
   → Minimal changes needed
   → Works!

6. ✅ EASY DEPLOYMENT
   ──────────────────
   User installs dotfiles on macOS:
   → git clone
   → git checkout macos
   → stow & done!
   
   User installs on Linux:
   → git clone
   → git checkout linux
   → stow & done!
   
   No manual selection of OS-specific files!

═══════════════════════════════════════════════════════════════════

⚠️  IMPORTANT: OS DETECTION IN CONFIGS

The main tmux.conf uses OS detection:

  ```bash
  if-shell "uname -s | grep -q Darwin" "source ~/.config/tmux/macos.conf"
  if-shell "uname -s | grep -q Linux" "source ~/.config/tmux/linux.conf"
  ```

This means:
  • Single tmux.conf works on ALL branches
  • Automatically loads OS-specific config
  • If you're on macOS, macos.conf is sourced
  • If you're on Linux, linux.conf is sourced

Why?
  • No need to maintain separate tmux.conf per branch
  • Single source of truth for core tmux config
  • You CAN use a single branch if you want!

═══════════════════════════════════════════════════════════════════

🔄 WORKFLOW EXAMPLE:

Day 1 (macOS):
  git clone ... && git checkout macos && stow shell tmux nvim ghostty

Day 2 (Update universal config):
  # Update git/.gitconfig
  git add git/.gitconfig
  git commit -m "Update git config"
  git push

Day 3 (Sync to Linux):
  git checkout linux && git merge main
  [linux branch now has updated git config]

Day 4 (Update macOS-specific):
  git checkout macos
  # Update shell/.zshrc for some homebrew path
  git add shell/.zshrc
  git commit -m "Fix homebrew path"
  git push

Day 5 (Deploy to new Mac):
  git clone ... && git checkout macos && stow shell tmux nvim ghostty
  [New Mac has all latest changes]

═══════════════════════════════════════════════════════════════════

📚 COMMAND REFERENCE:

Switch branch:
  git checkout macos
  git checkout linux
  git checkout main

See all branches:
  git branch -a

Merge main changes into macos:
  git checkout macos
  git merge main

See difference between branches:
  git diff main macos
  git log --graph --oneline --all  # See branch history

Sync after branch switch:
  git checkout macos
  cd ~/dotfiles
  # Unstow old configs
  stow -D wezterm
  # Stow new configs
  stow ghostty
  source ~/.zshrc

═══════════════════════════════════════════════════════════════════

✨ SUMMARY:

Branch Structure:
  main   ← Universal base
  macos  ← Inherits main + adds macOS stuff
  linux  ← Inherits main + adds Linux stuff

Benefits:
  ✅ No duplication
  ✅ Clear separation
  ✅ Easy to maintain
  ✅ Scales to multiple OS
  ✅ Clean git history
  ✅ User-friendly deployment

Usage:
  macOS:  git checkout macos && stow shell tmux nvim ghostty...
  Linux:  git checkout linux && stow shell tmux nvim wezterm...

═══════════════════════════════════════════════════════════════════
