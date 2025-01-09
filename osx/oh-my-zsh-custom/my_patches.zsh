# START SHYAMRCPATCH

# == prompt stuff

# customize to match your desired hostname moniker
export HOST_PREFIX="Mb "

# - Allow a shorter moniker to identify the HOST
# - Show the git branch name when inside a git repository directory
# - If the git branch name starts with `feature/foo`, shorten it as `F|foo`
# - If the git branch name starts with `personal/*/foo`, shorten it as `P|foo`
# - If the last command failed, show the arrow in red on the prompt. When there
#   was no error, it reverts to the normal color.

function git_prompt_info() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  ref="$(command echo ${ref#refs/heads/})"

  # if this is a personal branch, replace personal/yourname with P| prefix
  ref=$(echo ${ref} | sed "s/personal\/.*\//P\|/")

  # if this is a feature branch, replace feature/ with F|
  ref=$(echo ${ref} | sed "s/feature\//F\|/")

  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

PROMPT='$HOST_PREFIX%(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)'
PROMPT+=' %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%})"

# == aliases and other patches

#override default git log oneline alias
alias glo='git log --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# END SHYAMRCPATCH
