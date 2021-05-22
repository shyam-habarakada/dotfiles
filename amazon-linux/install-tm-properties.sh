#!/bin/bash

DOTFILES_DIR=~/.dotfiles

# install .tm_properties
if [ ! -f ~/.tm_properties ]; then
  ln -s $DOTFILES_DIR/textmate/tm_properties ~/.tm_properties
fi
