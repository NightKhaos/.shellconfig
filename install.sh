#!/bin/bash -e
ZSHRC_SOURCE=$(dirname $0)/zshrc
POWERLINE_CONFIG_DIR=$(dirname $0)/powerline

# Setup Shell
[ -e "$ZSHRC_SOURCE" ] && ( [ -e "$HOME/.zshrc" ] || ln -s "$ZSHRC_SOURCE" "$HOME/.zshrc" )
[ -e "$HOME/.zsh" ] || mkdir -p "$HOME/.zsh"

# Install Powerline Configuration
mkdir -p "$HOME/.config"
[ -e "$POWERLINE_CONFIG_DIR" ] && ( [ -e "$HOME/.config/powerline" ] || ln -s "$POWERLINE_CONFIG_DIR" "$HOME/.config/powerline")

# Install Powerline Fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
