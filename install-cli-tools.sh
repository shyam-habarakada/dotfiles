#!/bin/bash

# install homebrew https://brew.sh/
if ! [ -x "$(command -v brew)" ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# vim
brew install vim

# github CLI
brew install hub

# silver-searcher
brew install the_silver_searcher

