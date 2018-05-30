DOTFILES_DIR=~/.dotfiles

echo $DOTFILES_DIR/shell/colors

source $DOTFILES_DIR/shell/colors
source $DOTFILES_DIR/shell/aliases
source $DOTFILES_DIR/shell/editors
source $DOTFILES_DIR/shell/docker

# https://github.com/github/hub
if [ -f $DOTFILES_DIR/git/hub.bash_completion ]; then
  . $DOTFILES_DIR/git/hub.bash_completion
fi
