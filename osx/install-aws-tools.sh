#!/bin/bash

RC_FILE="$HOME/.zshrc"

# Install tgenv
if ! grep -q "tgenv" "$RC_FILE"; then
  git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv
  echo 'export PATH="$HOME/.tgenv/bin:$PATH"' >> "$RC_FILE"
else
  echo "tgenv already installed"
fi

# Install tfenv
if ! grep -q "tfenv" "$RC_FILE"; then
  git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
  echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> "$RC_FILE"
else
  echo "tfenv already installed"
fi


