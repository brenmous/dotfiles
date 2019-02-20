#!/bin/bash

sudo yum -y update
sudo yum -y install tmux vim

# install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# link to the dot files
curdir=`pwd`
cd ~
ln -fs "$curdir"/vimrc .vimrc
ln -fs "$curdir"/tmux.conf .tmux.conf
ln -fs "$curdir"/bash_aliases .bash_aliases # ensure that .bashrc loads this
ln -fs "$curdir"/bashrc .bashrc
cd "$curdir"

# configure git
git config --global user.name "Bren Moushall"
git config --global user.email "bmoush@gmail.com"
git config --global push.default simple
