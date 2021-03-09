export PATH=$PATH:/usr/local/bin:$HOME/.bin:$HOME/.dotfiles/bin
export PATH="/usr/local/opt/python@3.8/bin:$PATH"  # Python 3.8

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export ZSH=$HOME/.oh-my-zsh
export EDITOR=nano

alias tb="nc termbin.com 9999"
alias hgu="hg update"
alias hgm="hg merge"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias google-chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# -----------------------------------------------
# django
# -----------------------------------------------

alias mp="python manage.py"
alias mpm="python manage.py migrate"
alias mprs="python manage.py runserver"
alias mpmm="python manage.py makemigrations"

django-startproject() {
    PROJECT_DIR=$1
    hg clone ssh://hg@bitbucket.org/redisca/django-stub $PROJECT_DIR
    cd $PROJECT_DIR
    rm -rf .hg
    ./startproject.sh
    cd -
}

# -----------------------------------------------
# zsh
# -----------------------------------------------

DISABLE_AUTO_TITLE="true"
ZSH_THEME="robbyrussell"

DEFAULT_USER=maxim
ZSH_THEME_VIRTUALENV_PREFIX="[venv:"
ZSH_THEME_VIRTUALENV_SUFFIX="]"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

autoload -U add-zsh-hook
plugins=(virtualenv git mercurial zsh-autosuggestions zsh-z)
source $ZSH/oh-my-zsh.sh
unsetopt share_history

# -----------------------------------------------
# functions
# -----------------------------------------------

case "$OSTYPE" in
    darwin*)  PLATFORM="OSX" ;;
    linux*)   PLATFORM="LINUX" ;;
    bsd*)     PLATFORM="BSD" ;;
    *)        PLATFORM="UNKNOWN" ;;
esac

replace() {
    if [[ "$PLATFORM" == "OSX" || "$PLATFORM" == "BSD" ]]; then
        sed -i "" "$1" "$2"
    elif [[ "$PLATFORM" == "LINUX" ]]; then
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

upload() {
	echo "uploading file to static.zenwalker.me..."
	curl --progress-bar http://static.zenwalker.me -F "file=@$1"
}

add_to_path() {
    export PATH=$PATH:$1
}

check_certificate() {
    cert_hash=`openssl x509 -noout -modulus -in $1 | openssl md5`
    key_hash=`openssl rsa -noout -modulus -in $2 | openssl md5`

    if [[ $cert_hash == $key_hash ]]; then
        echo "✔ VALID"
    else
        echo "× INVALID"
    fi
}


# -----------------------------------------------
# docker shortcuts
# -----------------------------------------------

docker-psql() {
    CONTAINER=$1
    shift 1
    docker exec -it $CONTAINER psql $@
}

docker-sqlplus() {
    CONTAINER=$1
    docker exec -it $CONTAINER sqlplus system/oracle@//localhost:1521/xe
}

docker-stop-all() {
	docker stop $(docker ps -q)
}


# -----------------------------------------------
# java
# -----------------------------------------------

if [[ "$OSTYPE" == "LINUX" ]]; then
    # use smooth font for java applications
    export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd \
                          -Dsun.java2d.xrender=true"
fi


# -----------------------------------------------
# golang
# -----------------------------------------------

export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin
#export GOFLAGS="-mod=vendor"
export GO111MODULE=on

# -----------------------------------------------
# nvm
# -----------------------------------------------

NVM_SOURCE=$HOME/.nvm/nvm.sh
NVM_DIR=$HOME/.nvm
lazy_source nvm $NVM_SOURCE


# -----------------------------------------------
# pipenv
# -----------------------------------------------

export WORKON_HOME=$HOME/.virtualenvs
export PIPENV_DEFAULT_PYTHON_VERSION=3.6
export PIPENV_HIDE_EMOJIS=1
export PIPENV_NOSPIN=1


# -----------------------------------------------
# ansible
# -----------------------------------------------

# human-readeable ansible output
export ANSIBLE_STDOUT_CALLBACK=debug


# -----------------------------------------------
# iterm2 shell integration
# -----------------------------------------------

source ~/.iterm2_shell_integration.$(basename $SHELL)

set_window_title() {
    echo -ne "\e]1;${PWD/#$HOME/~}\a"
    # echo -ne "\e]1;${PWD##*/}\a"
}

PR_TITLEBAR=''
set_window_title
add-zsh-hook precmd set_window_title


# -----------------------------------------------
# pyenv
# -----------------------------------------------

pyenv_init() {
    if [[ $PYENV_VERSION == "" ]]; then
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi
}

venv() {
    pyenv_init

    name=$1
    if [[ $name == "" ]]; then
        name=$(basename $(pwd))
    fi

    pyenv activate $name
    if [[ $? == 0 ]]; then
        py_ver=$(python --version)
        echo "$name has been activated"
        echo "Python version: $py_ver"
    fi
}
