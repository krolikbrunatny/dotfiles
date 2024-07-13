#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config
export DOTS="$PWD/dotfiles"

# Bash
ln -sf "$DOTS/.bash_profile" "$HOME"/.bash_profile
ln -sf "$DOTS/.bashrc" "$HOME"/.bashrc

# Alacritty
mkdir -p "$XDG_CONFIG_HOME"/alacritty
ln -sf "$DOTS/alacritty.toml" "$XDG_CONFIG_HOME"/alacritty/alacritty.toml

