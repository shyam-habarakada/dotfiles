# Path to your oh-my-zsh installation.
export ZSH=/opt/apps/oh-my-zsh
export ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
export ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

[[ -f $HOME/.zshrc-private ]] && . $HOME/.zshrc-private

ZSH_THEME="smartypants"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(git docker-compose mvn smartsheet common-aliases last-working-dir)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker-compose mvn common-aliases last-working-dir dotenv)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias flushdns="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil"
alias gtw="glances --theme-white"
alias ctop="ctop -a -i"

# https://gist.github.com/evanscottgray/8571828#gistcomment-2594902
alias dcpurge='docker ps -q | xargs docker stop ; docker system prune -a'

# more git aliases
alias gundo="git reset HEAD~1"
alias grecommit="git commit --amend"
alias gconflicts="git diff --name-only --diff-filter=U"
alias gd="git difftool"

# nvm
export NVM_DIR="/home/shabarakada/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# jinja and other pip binaries
export PATH=$PATH:~/.local/bin
# BEGIN ANSIBLE MANAGED BLOCK
echo ""
echo "      ╔═╗┌┬┐┌─┐┬─┐┌┬┐┌─┐┬ ┬┌─┐┌─┐┌┬┐";
echo "      ╚═╗│││├─┤├┬┘ │ └─┐├─┤├┤ ├┤  │ ";
echo "      ╚═╝┴ ┴┴ ┴┴└─ ┴ └─┘┴ ┴└─┘└─┘ ┴ ";
echo ""
echo "Welcome to smartsheet cloud (EC2) build environment"
# END ANSIBLE MANAGED BLOCK
# BEGIN ANSIBLE MANAGED BLOCK (personalized.yaml)
# Short host identifier for smartypants zsh theme. This string will
# be used in place of the default hostname prefix when you are in an
# interactive shell. If you have multiple backend hosts, consider
# using a host specific variable in your hosts file so this is a unique
# identifier per remote host.
export HOST_PREFIX=D2\|

# override default git diff alias
alias gd='git difftool'

#override default git log oneline alias
alias glo='git log --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# app-core build (acb) helper, a wrapper around the app-core build script
# usage,
#   acb -f - run a full build.
#   acb -h - help on other options
function acb() {
  current_directory_saved=`pwd`
  cd $GIT_APP_CORE

  case $1 in
  lint)
    pushd dev2/web/javascript/legacyApp
    npm run lint-ts && npm run build:ts
    popd
    ;;
  *)
    ./src/main/build/build.sh $@
    ;;
  esac

  cd $current_directory_saved
}
# END ANSIBLE MANAGED BLOCK (personalized.yaml)
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
