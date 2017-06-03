# based on https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/pure.zsh-theme

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable hg git

zstyle ':vcs_info:hg:*' get-bookmarks true
zstyle ':vcs_info:hg:*' use-simple true

zstyle ':vcs_info:git:*' formats "%s:%b"
zstyle ':vcs_info:hg:*'  formats "%s:%b%m"


precmd() {
    vcs_info
}

local ret_status="%(?:%{$fg_bold[green]%}λ:%{$fg_bold[red]%}λ%s)"
PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$reset_color%}'
RPROMPT='%{$fg[yellow]%}$(virtualenv_prompt_info) %{$fg_bold[blue]%}$vcs_info_msg_0_%{$reset_color%}'

# Uncomment for verbose debugg info
#zstyle ':vcs_info:*+*:*' debug true
