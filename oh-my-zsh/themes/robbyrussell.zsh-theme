local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$reset_color%}'
RPROMPT='%{$fg[yellow]%}$(virtualenv_prompt_info) %{$fg_bold[blue]%}$(git_prompt_info)$(hg_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗%{$reset_color%}"

ZSH_THEME_HG_PROMPT_PREFIX="hg:"
