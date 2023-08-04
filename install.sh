#!/bin/bash -e
cd "$(dirname $0)"
WHEREAMI=$(pwd)
cd -
ZSHRC_SOURCE=$WHEREAMI/zshrc
ZSHENV_SOURCE=$WHEREAMI/zshenv
ZPROFILE_SOURCE=$WHEREAMI/zprofile

# Install Starship
if [[ $(uname -m) != "armv7l" ]] && ! which starship >/dev/null 2>/dev/null
then
  curl -sS https://starship.rs/install.sh | sh
fi

# Setup Shell
[ -e "$ZSHRC_SOURCE" ] && ( [ -L "$HOME/.zshrc" ] || ( rm -f "$HOME/.zshrc" && ln -s "$ZSHRC_SOURCE" "$HOME/.zshrc" ) )
[ -e "$ZSHENV_SOURCE" ] && ( [ -L "$HOME/.zshenv" ] || ( rm -f "$HOME/.zshenv" && ln -s "$ZSHENV_SOURCE" "$HOME/.zshenv" ) )
[ -e "$ZPROFILE_SOURCE" ] && ( [ -L "$HOME/.zprofile" ] || ( rm -f "$HOME/.zprofile" && ln -s "$ZPROFILE_SOURCE" "$HOME/.zprofile" ) )
[ -e "$HOME/.zsh" ] || mkdir -p "$HOME/.zsh"
