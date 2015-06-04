# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

#ZSH_THEME="robbyrussell"
ZSH_THEME="jreese"

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

plugins=(git mercurial debian)

source $ZSH/oh-my-zsh.sh

unsetopt share_history

export PATH=$PATH:~/.bin:~/.dotfiles/bin

# export ARCHFLAGS="-arch x86_64"
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# golang
export GOPATH="$HOME/.golang"

# dpkg
export DEBEMAIL="zenwalker2@gmail.com"

# functions

ssh-push-key () {
    cat ~/.ssh/id_rsa.pub | ssh $1 'cat >> ~/.ssh/authorized_keys'
}

# java

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd \
                      -Dsun.java2d.xrender=true"

# sources

VIRTUALENV_SOURCE="/usr/share/virtualenvwrapper/virtualenvwrapper.sh"
NVM_SOURCE="$HOME/.nvm/nvm.sh"

[ -f $VIRTUALENV_SOURCE ] && source $VIRTUALENV_SOURCE
[ -f $NVM_SOURCE ] && source ~/.nvm/nvm.sh
