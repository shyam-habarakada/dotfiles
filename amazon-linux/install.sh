#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# install vim components
ln -sf $DIR/../vim ~/.vim
ln -sf $DIR/../vim/vimrc ~/.vimrc

# install .agignore
ln -sf $DIR/agignore ~/.agignore

