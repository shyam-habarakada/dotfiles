#!/bin/bash

# java
brew install java
brew install java11

# activate java11
echo 'export PATH="/usr/local/opt/openjdk@11/bin:$PATH"' >> ~/.zshrc
echo 'export CPPFLAGS="-I/usr/local/opt/openjdk@11/include"' >> ~/.zshrc



