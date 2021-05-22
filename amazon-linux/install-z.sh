#!/bin/zsh

# set zsh as the default
chsh -s /bin/zsh

# install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

