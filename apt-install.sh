#!/bin/bash

sudo apt-get update -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo add-apt-repository ppa:jonathonf/vim -y

sudo apt-get install -y \
    tmux \
    git \
    vim \
    python3.7

# Install node.js
curl -L install-node.now.sh/lts -o /tmp/install-node.sh
chmod u+rwx /tmp/install-node.sh
sudo /tmp/install-node.sh -y

mkdir -p ~/.vim/pack/plugins/start
# Plugins
# Linting engine
git clone https://github.com/w0rp/ale.git ~/.vim/pack/plugins/start/ale
# Autocomplete
curl --L https://github.com/neoclide/coc.nvim/archive/release.tar.gz \
    | tar xzfv - -C ~/.vim/pack/plugins/start/ # Requires node.js
# Rust linter
# git clone https://github.com/rust-lang/rust.vim ~/.vim/pack/plugins/start/rust.vim

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

# install Python3.7
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.7
sudo apt install python3.7-venv
sudo apt install python3.7-dev
