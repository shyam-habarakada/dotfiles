DOTFILES_DIR=~/.dotfiles

source $DOTFILES_DIR/shell/colors
source $DOTFILES_DIR/shell/aliases
source $DOTFILES_DIR/shell/editors
source $DOTFILES_DIR/shell/docker

if [ -f $(brew --prefix)/etc/bash_completion ]; then
   . $(brew --prefix)/etc/bash_completion
fi

# https://github.com/github/hub
if [ -f $DOTFILES_DIR/git/hub.bash_completion.sh ]; then
  cat $DOTFILES_DIR/git/hub.bash_completion.sh
  . $DOTFILES_DIR/git/hub.bash_completion.sh
fi
