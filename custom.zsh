# short identifier in place of the full hostname
HOST_MONICKER=D9

PROMPT='$HOST_MONICKER %F{green}%3~ $(git_prompt_info)%B%(!.%F{red}.%F{blue})%f%b'
RPS1='%(?..%B%F{red}%?%b ↵%f)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}*%{$fg[yellow]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=")%{$reset_color%} "

