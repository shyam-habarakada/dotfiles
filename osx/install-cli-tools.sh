#!/bin/bash

# xcode
echo 'Installing xcode-select...'
xcode-select --install

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install homebrew https://brew.sh/
if ! [ -x "$(command -v brew)" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# vim
brew install vim

# bash-eompletion
brew install bash-completion

# better git
brew install git

# text interface to git
# https://jonas.github.io/tig/
brew install tig

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

# http_load
brew install http_load

# aws-okta-keyman
brew tap nathan-v/aws-okta-keyman
brew install aws_okta_keyman

brew install ansible

