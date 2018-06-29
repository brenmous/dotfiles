#!/bin/bash

sudo apt-get update

sudo apt-get install -y \
    tmux \
    git git-gui \
    python-dev python-examples ipython \
    tree \
    evince

# install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# link to the dot files
curdir=`pwd`
cd ~
ln -s "$curdir"/vimrc .vimrc
ln -s "$curdir"/tmux.conf .tmux.conf
ln -s "$curdir"/bash_aliases .bash_aliases # ensure that .bashrc loads this
cd "$curdir"

# configure git
git config --global user.name "Simon Knapp"
git config --global user.email "sleepingwell@gmail.com"
git confit --global push.default simple

# get pip
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
