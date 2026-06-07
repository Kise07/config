#!/bin/bash
set -e

echo "🚀 Setting up dotfiles with Stow..."

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Stow is installed
if ! command -v stow &> /dev/null; then
    echo -e "${YELLOW}⚠️  Stow not found. Installing...${NC}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install stow
    else
        sudo apt-get install stow
    fi
fi

# Navigate to dotfiles directory
cd "$(dirname "${BASH_SOURCE[0]}")"
DOTFILES_DIR="$(pwd)"

echo -e "${BLUE}📁 Dotfiles directory: ${DOTFILES_DIR}${NC}"

# List available modules
echo -e "${BLUE}📦 Available modules:${NC}"
ls -1d */ | sed 's|/$||' | nl

# Prompt user for modules to install
read -p "Enter modules to install (space-separated, e.g., 'shell tmux nvim'): " -r MODULES

if [[ -z "$MODULES" ]]; then
    echo -e "${YELLOW}No modules selected. Exiting.${NC}"
    exit 0
fi

# Install modules
echo -e "${BLUE}⚙️  Installing modules...${NC}"
for module in $MODULES; do
    if [[ -d "$module" ]]; then
        echo -e "${BLUE}→ Stowing ${module}...${NC}"
        stow --verbose=2 "$module"
        echo -e "${GREEN}✅ ${module} installed${NC}"
    else
        echo -e "${YELLOW}⚠️  Module '${module}' not found. Skipping.${NC}"
    fi
done

echo ""
echo -e "${GREEN}✨ Stow setup complete!${NC}"
echo ""
echo "🔍 Verify installation:"
echo "   ls -la ~/ | grep '^l'    # Check symlinks in home"
echo "   source ~/.zshrc          # Reload shell config"
echo ""
echo "📚 See README.md for more details"
