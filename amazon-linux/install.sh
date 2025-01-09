#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# install .agignore
ln -sf $DIR/agignore ~/.agignore

# install other CLI tools
sudo yum install -y jq

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# copy our custom prompt
cp $DIR/../custom.zsh $HOME/.oh-my-zsh/custom/custom.zsh

# turn off the default theme
sed -i "/ZSH_THEME=/ s/^/# /" ~/.zshrc

# install .vimrc
VIMRC="$HOME/.vimrc"
if [ -f "$VIMRC" ]; then
  mv $VIMRC "$VIMRC.bakup"
fi
ln -s $DIR/../vimrc $HOME/.vimrc

