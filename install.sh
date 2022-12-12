#!/bin/bash -e
cd "$(dirname $0)"
WHEREAMI=$(pwd)
cd -
ZSHRC_SOURCE=$WHEREAMI/zshrc

# Install Starship
if [[ $(uname -m) != "armv7l" ]] && ! which starship >/dev/null 2>/dev/null
then
  curl -sS https://starship.rs/install.sh | sh
else
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

# Setup Shell
[ -e "$ZSHRC_SOURCE" ] && ( [ -L "$HOME/.zshrc" ] || ( rm -f "$HOME/.zshrc" && ln -s "$ZSHRC_SOURCE" "$HOME/.zshrc" ) )
[ -e "$HOME/.zsh" ] || mkdir -p "$HOME/.zsh"
