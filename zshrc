export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

alias won="workon"
alias mp="./manage.py"
alias mprs="./manage.py runserver"
alias mpfs="./manage.py frontend"
alias mpmm="./manage.py makemigrations"
alias mpm="./manage.py migrate"


plugins=(git mercurial virtualenv fabric terminalapp web-search)

source $ZSH/oh-my-zsh.sh

unsetopt share_history

export PATH=$PATH:$HOME/.bin:$HOME/.dotfiles/bin
export EDITOR=nano

# locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# dpkg
export DEBEMAIL="zenwalker2@gmail.com"


# functions

push_ssh_key () {
    cat ~/.ssh/id_rsa.pub | ssh $1 'cat >> ~/.ssh/authorized_keys'
}

lazy_source () {
    eval "$1 () { [ -f $2 ] && source $2 && $1 \$@ }"
}

fix_id3() {
    find. -name "*.mp3" -print0 | xargs -0 mid3iconv -e CP1251 -d
}

# java

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd \
                      -Dsun.java2d.xrender=true"


# golang

export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin


# nvm

NVM_SOURCE=$(brew --prefix nvm)/nvm.sh
NVM_DIR=$HOME/.nvm

lazy_source nvm $NVM_SOURCE


# virtualenv

VIRTUALENV_SOURCE=/usr/local/bin/virtualenvwrapper.sh
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

_venv_commands=(workon mkvirtualenv rmvirtualenv)

for command in "${_venv_commands[@]}"; do
    lazy_source $command $VIRTUALENV_SOURCE
done

unset _venv_commands
