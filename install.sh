#!/bin/bash -e
cd "$(dirname $0)"
WHEREAMI=$(pwd)
cd -
ZSHRC_SOURCE=$WHEREAMI/zshrc
POWERLINE_CONFIG_DIR=$WHEREAMI/powerline

# Setup Shell
[ -e "$ZSHRC_SOURCE" ] && ( [ -L "$HOME/.zshrc" ] || rm -f "$HOME/.zshrc" && ln -s "$ZSHRC_SOURCE" "$HOME/.zshrc" )
[ -e "$HOME/.zsh" ] || mkdir -p "$HOME/.zsh"

# Install Powerline Configuration
mkdir -p "$HOME/.config"
[ -e "$POWERLINE_CONFIG_DIR" ] && ( [ -e "$HOME/.config/powerline" ] || ln -s "$POWERLINE_CONFIG_DIR" "$HOME/.config/powerline")


