#!/bin/zsh

set -euo pipefail

export XDG_CONFIG_HOME="$HOME"/.config
SCRIPT_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)"
export DOTS="$SCRIPT_DIR/dotfiles"

# ============================================
# PREREQUISITES
# ============================================
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x "/opt/homebrew/bin/brew" ]]; then
  BREW_BIN="/opt/homebrew/bin/brew"
elif [[ -x "/usr/local/bin/brew" ]]; then
  BREW_BIN="/usr/local/bin/brew"
else
  echo "Homebrew installation did not provide a supported brew executable." >&2
  exit 1
fi

eval "$("$BREW_BIN" shellenv)"

# ============================================
# PACKAGES
# ============================================
"$BREW_BIN" bundle --no-upgrade --file "$SCRIPT_DIR/Brewfile"

# ============================================
# OH MY ZSH
# ============================================
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ============================================
# SHELL
# ============================================
ln -sf "$DOTS/.zprofile" "$HOME"/.zprofile
ln -sf "$DOTS/.zshrc" "$HOME"/.zshrc
ln -sf "$DOTS/.hushlogin" "$HOME"/.hushlogin

# OpenCode
mkdir -p "$HOME/.opencode/scratch"

# ============================================
# APPLICATION CONFIGURATION
# ============================================
# Ghostty
mkdir -p "$XDG_CONFIG_HOME"/ghostty
ln -sf "$DOTS/ghostty" "$XDG_CONFIG_HOME"/ghostty/config

# AeroSpace
mkdir -p "$XDG_CONFIG_HOME"/aerospace
ln -sf "$DOTS/aerospace.toml" "$XDG_CONFIG_HOME"/aerospace/aerospace.toml
open -a AeroSpace

# tmux
ln -sf "$DOTS/.tmux.conf" "$HOME"/.tmux.conf

# Git
ln -sf "$DOTS/.gitignore" "$HOME"/.gitignore
git config --global core.excludesfile "$HOME/.gitignore"

# ============================================
# MACOS PREFERENCES
# ============================================
zsh "$SCRIPT_DIR/macos.sh"

# ============================================
# GOOGLE CLOUD CLI
# ============================================
# Its Homebrew cask builds a Python virtualenv in a slow, networked postflight step.
if ! command -v gcloud >/dev/null 2>&1; then
  echo "Installing Google Cloud CLI. Its Python setup can take several minutes without output."
  if "$BREW_BIN" list --cask gcloud-cli >/dev/null 2>&1; then
    GCLOUD_BREW_ACTION="reinstall"
  else
    GCLOUD_BREW_ACTION="install"
  fi

  if ! "$BREW_BIN" "$GCLOUD_BREW_ACTION" --cask gcloud-cli; then
    echo "Google Cloud CLI installation failed; retry with: brew reinstall --cask gcloud-cli" >&2
  fi
fi

echo "Setup complete. Open a new terminal, then finish the first-run steps in README.md."
