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

function {
  if [[ -n "$SSH_CLIENT" ]]; then
    if [[ -v HOST_PREFIX ]]; then
      PROMPT_HOST="$HOST_PREFIX "
    else
      PROMPT_HOST="$HOST "
    fi
  else
    PROMPT_HOST=''
  fi
}

PROMPT="${PROMPT_HOST}%(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
