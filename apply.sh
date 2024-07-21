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

# aerospace
mkdir -p "$XDG_CONFIG_HOME"/aerospace
ln -sf "$DOTS/aerospace.toml" "$XDG_CONFIG_HOME"/aerospace/aerospace.toml

# tmux
ln -sf "$DOTS/.tmux.conf" "$HOME"/.tmux.conf

# skhd
mkdir -p "$XDG_CONFIG_HOME"/skhd
ln -sf "$DOTS/skhdrc" "$XDG_CONFIG_HOME"/skhd/skhdrc

# nvim
ln -sf "$DOTS/nvim" "$XDG_CONFIG_HOME"/nvim
