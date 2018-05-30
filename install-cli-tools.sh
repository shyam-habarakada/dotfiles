#!/bin/bash

# (re)install homebrew https://brew.sh/
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install github CLI (developer branch)
brew install --devel hub

