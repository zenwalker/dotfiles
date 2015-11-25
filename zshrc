export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
#ZSH_THEME="jreese"

# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder

alias won='workon'
alias mp='./manage.py'
alias mpr='./manage.py runserver'
alias mpmm='./manage.py makemigrations'
alias mpm='./manage.py migrate'


plugins=(git mercurial debian)

source $ZSH/oh-my-zsh.sh

unsetopt share_history

export PATH=$PATH:~/.bin:~/.dotfiles/bin

# export ARCHFLAGS="-arch x86_64"
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# golang
export GOPATH="$HOME/.golang"


# dpkg
export DEBEMAIL="zenwalker2@gmail.com"


# functions

push_ssh_key () {
    cat ~/.ssh/id_rsa.pub | ssh $1 'cat >> ~/.ssh/authorized_keys'
}

lazy_source () {
    eval "$1 () { [ -f $2 ] && source $2 && $1 \$@ }"
}


# java

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd \
                      -Dsun.java2d.xrender=true"


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
