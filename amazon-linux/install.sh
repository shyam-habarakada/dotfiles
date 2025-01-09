#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# install vim components
ln -sf $DIR/../vim ~/.vim
ln -sf $DIR/../vim/vimrc ~/.vimrc

# install .agignore
ln -sf $DIR/agignore ~/.agignore

# install other CLI tools
sudo yum install -y jq

# patch zshrc, if not already patched
grep -qF "SHYAMRCPATCH" ~/.zshrc || cat $DIR/zshrc.patch >> ~/.zshrc
