#!/bin/zsh

set -euo pipefail

# ============================================
# KEYBOARD
# ============================================
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

# ============================================
# TRACKPAD
# ============================================
defaults write -g com.apple.swipescrolldirection -boolean NO
