#!/bin/bash

DOTFILES_DIR=~/.dotfiles
BACKUP_DIR=~/.dotfiles.backup

# timestamp for backup copies of dotfiles
TIMESTAMP=$(date +"%Y%m%d%H%M")

# list dotfiles to install
FILES="bashrc vimrc vim"

if [ -d $BACKUP_DIR ]
then
  echo "Creating $BACKUP_DIR to backup current dotfiles ~"
  mkdir -p $BACKUP_DIR
fi

for file in $FILES; do
  mv ~/.$file $BACKUP_DIR/.$file.$TIMESTAMP
  echo "Installing $file"
  ln -s $DOTFILES_DIR/$file ~/.$file
done
