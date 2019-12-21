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
