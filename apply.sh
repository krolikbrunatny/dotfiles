#!/bin/zsh

export XDG_CONFIG_HOME="$HOME"/.config
export DOTS="$PWD/dotfiles"

# bash
ln -sf "$DOTS/.zprofile" "$HOME"/.zprofile
ln -sf "$DOTS/.zshrc" "$HOME"/.zshrc
ln -sf "$DOTS/.hushlogin" "$HOME"/.hushlogin

# alacritty
mkdir -p "$XDG_CONFIG_HOME"/alacritty
ln -sf "$DOTS/alacritty.toml" "$XDG_CONFIG_HOME"/alacritty/alacritty.toml

# aerospace
mkdir -p "$XDG_CONFIG_HOME"/aerospace
ln -sf "$DOTS/aerospace.toml" "$XDG_CONFIG_HOME"/aerospace/aerospace.toml
## add to login items
AEROSPACE_PATH="/Applications/AeroSpace.app"
osascript -e "try
    tell application \"System Events\" to make new login item at end with properties {path:\"$AEROSPACE_PATH\", hidden:false}
end try" > /dev/null 2>&1

# tmux
ln -sf "$DOTS/.tmux.conf" "$HOME"/.tmux.conf

# skhd
mkdir -p "$XDG_CONFIG_HOME"/skhd
ln -sf "$DOTS/skhdrc" "$XDG_CONFIG_HOME"/skhd/skhdrc

# nvim
ln -sf "$DOTS/nvim" "$XDG_CONFIG_HOME"/nvim

# k9s
mkdir -p "$XDG_CONFIG_HOME"/k9s
ln -sf "$DOTS/k9s/skin.yml" "$XDG_CONFIG_HOME"/k9s/skin.yml
