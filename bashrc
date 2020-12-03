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
  . $DOTFILES_DIR/git/hub.bash_completion.sh
fi

# aws helpers
alias awsdesc="aws ec2 describe-instances --filter Name=tag-key,Values=Name --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,IpAddress:PrivateIpAddress,keyPairName:KeyName,Name:Tags[?Key==\`Name\`]|[0].Value}' --output table"
function myssm() {
    INSTID=$(awsdesc | grep $1 | awk '{print $3}')
    echo $INSTID,$1
    aws ssm start-session --target $INSTID
}

# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# java sdk
export JAVA_HOME=$(/usr/libexec/java_home)

export PATH="$JAVA_HOME/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
