═══════════════════════════════════════════════════════════════════
  🖥️ MULTI-OS DOTFILES STRATEGY - TWO APPROACHES
═══════════════════════════════════════════════════════════════════

You have two excellent options for handling macOS + Linux:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

APPROACH 1: SINGLE BRANCH WITH OS DETECTION (RECOMMENDED) ⭐
────────────────────────────────────────────────────────────────

Structure:
  ~/dotfiles/
  ├── main/              # Shared configs
  │   ├── .gitconfig
  │   └── nvim/
  ├── macos/             # macOS-only
  │   ├── shell/
  │   ├── tmux/
  │   └── ghostty/
  ├── linux/             # Linux-only
  │   ├── shell/
  │   ├── tmux/
  │   └── wezterm/       # Linux terminal emulator
  └── setup-os.sh        # Auto-detect and deploy

How it works:
  1. Keep universal configs in main/
  2. OS-specific in macos/ and linux/
  3. setup-os.sh detects OS and runs appropriate stow
  
  ```bash
  # Automatically detects OS and stows appropriate modules
  bash ~/dotfiles/setup-os.sh
  ```

Pros:
  ✅ Single repo, single branch
  ✅ Easy to switch between OS
  ✅ Clear organization
  ✅ Easy to add new OS (windows/)
  ✅ Good for version control (all changes in main)

Cons:
  ❌ Need OS detection script
  ❌ Manual stowing of OS-specific modules


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

APPROACH 2: SEPARATE GIT BRANCHES (What you asked for)
──────────────────────────────────────────────────────────────────

Structure:
  main        → Base configs (universal)
    ├── nvim/
    ├── git/
    └── scripts/
  
  macos       → Extends main branch
    ├── shell/
    ├── tmux/
    ├── ghostty/
    └── [inherits from main]
  
  linux       → Extends main branch
    ├── shell/
    ├── tmux/
    ├── wezterm/
    └── [inherits from main]

How it works:
  1. Clone main branch
  2. Check out macos or linux branch
  3. Stow as usual
  
  ```bash
  # For macOS
  git checkout macos
  stow shell tmux ghostty nvim git scripts
  
  # For Linux
  git checkout linux
  stow shell tmux wezterm nvim git scripts
  ```

Pros:
  ✅ Clear separation per OS
  ✅ Can have completely different configs per branch
  ✅ Easy to test changes: git checkout linux && test
  ✅ Git history shows OS-specific changes

Cons:
  ❌ Need to maintain 3 branches
  ❌ Harder to sync universal configs across branches
  ❌ More git complexity


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

COMPARISON:

Feature              Single Branch   Multiple Branches
─────────────────────────────────────────────────────
Easy to sync         ✅ Yes          ❌ No (merge hell)
Clear OS separation  ⚠️  Medium       ✅ Yes
Complexity           ✅ Low           ❌ High
Learning curve       ✅ Easy          ❌ Harder
Scaling to N OS      ✅ Good          ⚠️  Gets messy

═══════════════════════════════════════════════════════════════════

RECOMMENDATION: Use Approach 1 (Single Branch with OS Detection)

Why?
  • You get the benefits of branches without the complexity
  • Easier to maintain and sync universal configs
  • Cleaner git history
  • Scales better if you add more systems later
  • Still has clear OS separation in folder structure

═══════════════════════════════════════════════════════════════════
