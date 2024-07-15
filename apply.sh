#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config
export DOTS="$PWD/dotfiles"

# bash
ln -sf "$DOTS/.bash_profile" "$HOME"/.bash_profile
ln -sf "$DOTS/.bashrc" "$HOME"/.bashrc
ln -sf "$DOTS/.hushlogin" "$HOME"/.hushlogin

# alacritty
mkdir -p "$XDG_CONFIG_HOME"/alacritty
ln -sf "$DOTS/alacritty.toml" "$XDG_CONFIG_HOME"/alacritty/alacritty.toml

# tmux
ln -sf "$DOTS/.tmux.conf" "$HOME"/.tmux.conf


