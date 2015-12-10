#!/bin/bash

$SOURCE="~/.dotfiles"

ln -s $SOURCE/vimrc ~/.vimrc
ln -s $SOURCE/zshrc ~/.zshrc
ln -s $SOURCE/gemrc ~/.gemrc
ln -s $SOURCE/sublime-text ~/.config/sublime-text-3/Packages/User

if [ -d ~/.oh-my-zsh ]; then
    ln -s $SOURCE/oh-my-zsh ~/.oh-my-zsh/custom
fi
