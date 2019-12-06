#!/bin/bash

# xcode
echo 'Installing xcode-select...'
xcode-select --install

# install homebrew https://brew.sh/
if ! [ -x "$(command -v brew)" ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# vim
brew install vim

# bash-eompletion
brew install bash-completion

# better git
brew install git

# github CLI
brew install hub

# silver-searcher
brew install the_silver_searcher

# glances
brew install glances

# telnet
brew install telnet

# mysql-client
brew install mysql-client

# nvm
brew install nvm
mkdir ~/.nvm

# ctop
brew install ctop

# awscli
brew install awscli

