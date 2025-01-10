# Allow overriding
if [ -n "$SHORT_HOSTNAME" ]; then
  HOST_MONICKER="$SHORT_HOSTNAME"
else
  HOST_MONICKER="${HOST%%.*}"
fi

PROMPT='%B%F{blue}$HOST_MONICKER%b %F{green}%3~ $(git_prompt_info)%B%(!.%F{red}.%F{blue})%f%b'
RPS1='%(?..%B%F{red}%?%b ↵%f)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}*%{$fg[yellow]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=")%{$reset_color%} "

