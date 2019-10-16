#!/bin/bash

DOTFILES_DIR=~/.dotfiles
BACKUP_DIR=~/.dotfiles.backup

# timestamp for backup copies of dotfiles
TIMESTAMP=$(date +"%Y%m%d%H%M")

# list dotfiles to install
FILES="bashrc vimrc vim screenrc"

mkdir -p $BACKUP_DIR

for file in $FILES; do
  mv ~/.$file $BACKUP_DIR/.$file.$TIMESTAMP
  echo "Installing $file"
  ln -s $DOTFILES_DIR/$file ~/.$file
done

# install .gitconfig
[ -f ~/.gitconfig ] && mv ~/.gitconfig $BACKUP_DIR/.gitconfig.$TIMESTAMP
[ -f ~/.gitignore_global ] && mv ~/.gitignore_global $BACKUP_DIR/.gitignore_global.$TIMESTAMP
echo "Installing .gitconfig files"
ln -s $DOTFILES_DIR/git/gitconfig ~/.gitconfig
ln -s $DOTFILES_DIR/git/gitignore_global ~/.gitignore_global

# ensure .bash_profile exists and is loading .bashrc
if [ ! -f ~/.bash_profile ]; then
  echo "Installing minimal .bash_profile"
  cp $DOTFILES_DIR/bash_profile ~/.bash_profile
fi

# install .tm_properties
if [ ! -f ~/.tm_properties ]; then
  ln -s $DOTFILES_DIR/textmate/tm_properties ~/.tm_properties
fi
