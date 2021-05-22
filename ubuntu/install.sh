#!/bin/bash

DOTFILES_DIR=~/.dotfiles
BACKUP_DIR=~/.dotfiles.backup

# timestamp for backup copies of dotfiles
TIMESTAMP=$(date +"%Y%m%d%H%M")

# list dotfiles to install
declare -a FILES=("vimrc" "vim" "screenrc" "zshrc" "oh-my-zsh-custom" "gitconfig" "agignore")

mkdir -p $BACKUP_DIR

for file in "${FILES[@]}"; do
  mv ~/.$file $BACKUP_DIR/.$file.$TIMESTAMP
  echo "Installing $file"
  ln -s $DOTFILES_DIR/$file ~/.$file
done

# ensure .bash_profile exists and is loading .bashrc
if [ ! -f ~/.bash_profile ]; then
  echo "Installing minimal .bash_profile"
  cp $DOTFILES_DIR/bash_profile ~/.bash_profile
fi
