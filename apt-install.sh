#!/bin/bash

sudo add-apt-repository ppa:jonathonf/vim
sudo apt-get update

sudo apt-get install -y \
    tmux \
    git \
    vim

mkdir -p ~/.vim/pack/plugins/start
# Plugins
git clone https://github.com/w0rp/ale.git ~/.vim/pack/plugins/start/ale
git clone https://github.com/rust-lang/rust.vim ~/.vim/pack/plugins/start/rust.vim

# link to the dot files
curdir=`pwd`
cd ~
ln -sfn "$curdir"/vim8/vimrc .vimrc
ln -sfn "$curdir"/tmux.conf .tmux.conf
ln -sfn "$curdir"/bash_aliases .bash_aliases # ensure that .bashrc loads this
ln -sfn "$curdir"/bashrc .bashrc
cd "$curdir"

# configure git
git config --global user.name "Bren Moushall"
git config --global user.email "bmoush@gmail.com"
git config --global push.default simple
