export ZSH=$HOME/.oh-my-zsh

export EDITOR=micro

ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"

alias won="venv"
alias mp="python manage.py"
alias mprs="mp runserver"
alias mpfs="mp frontend"
alias mpmm="mp makemigrations"
alias mpm="mp migrate"
alias edit="$EDITOR"
alias hosts="sudo $EDITOR /etc/hosts"

# mercurial
alias hgu="hg update"
alias hgm="hg merge"

plugins=(virtualenv git mercurial)

source $ZSH/oh-my-zsh.sh

unsetopt share_history

export PATH=$PATH:$HOME/.bin:$HOME/.dotfiles/bin

# locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# dpkg
export DEBEMAIL="max.poletaev@gmail.com"

# ---------
# functions
# ---------

case "$OSTYPE" in
    darwin*)  PLATFORM="OSX" ;;
    linux*)   PLATFORM="LINUX" ;;
    bsd*)     PLATFORM="BSD" ;;
    *)        PLATFORM="UNKNOWN" ;;
esac

replace() {
    if [[ "$PLATFORM" == "OSX" || "$PLATFORM" == "BSD" ]]; then
        sed -i "" "$1" "$2"
    elif [ "$PLATFORM" == "LINUX" ]; then
        sed -i "$1" "$2"
    fi
}

lazy_source () {
    eval "$1 () { [ -f $2 ] && source $2 && $1 \$@ }"
}

fix_id3_tags() {
    find. -name "*.mp3" -print0 | xargs -0 mid3iconv -e CP1251 -d
}

grep_files() {
	ggrep -rio --exclude-dir={node_modules,bower_componens.idea,.git,.hg} $1 $2
}

venv() {
    venv=$1

    if [[ ! $venv ]]; then
        if [[ -f ".venvrc" ]]; then
            venv=$(cat .venvrc | sed "s/^ *//;s/ *$//")
        elif [[ -d ".venv" ]]; then
            source .venv/bin/activate
        else
            venv=$(basename $(pwd))
        fi
    fi

    workon $venv 2>/dev/null
    if [ $? -ne 0 ]; then
        venv="$venv/bin/activate"
        if [[ -f $venv ]]; then
            source $venv
        fi
    fi
}

update-window-title() {
	echo -ne "\e]1;$PWD\a"
}

precmd() {
	update-window-title
}

# ----
# java
# ----

if [[ "$OSTYPE" == "LINUX" ]]; then
    # use smooth font for java applications
    export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd \
                          -Dsun.java2d.xrender=true"
fi

# ------
# golang
# ------

export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin

# ---
# nvm
# ---

NVM_SOURCE=$HOME/.nvm/nvm.sh
NVM_DIR=$HOME/.nvm

lazy_source nvm $NVM_SOURCE

# ----------
# virtualenv
# ----------

VIRTUALENV_SOURCE=/usr/local/bin/virtualenvwrapper.sh
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

_venv_commands=(workon mkvirtualenv rmvirtualenv lsvirtualenv)
for command in "${_venv_commands[@]}"; do
    lazy_source $command $VIRTUALENV_SOURCE
done
unset _venv_commands


# iterm2 shell integration

source ~/.iterm2_shell_integration.`basename $SHELL`

