#!/bin/bash
# Tested on Ubuntu 18.04
set -euo pipefail

# apt
sudo apt-get update -y
sudo apt-get upgrade -y
sudo add-apt-repository ppa:deadsnakes/ppa -y

sudo apt-get install -y \
    tmux \
    neovim \
    git \
    python3.7 \
    python3.7-venv \
    python3.7-dev \
    python3-pip

python3.7 -m pip install pip
pip install virtualenv

# Update to latest nvim image
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o /tmp/nvim.appimage
sudo mv /tmp/nvim.appimage /usr/local/bin/nvim
chmod u+x /usr/local/bin/nvim

# venv dir
mkdir -p ~/.venvs

# neovim
mkdir -p ~/.config/nvim

python3.7 -m venv ~/.venvs/nvim3
. ~/.venvs/nvim3/bin/activate
pip install pynvim
pip install jedi
deactivate

python2.7 -m virtualenv ~/.venvs/nvim2
. ~/.venvs/nvim2/bin/activate
pip install pynvim
deactivate

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# link to the dot files
curdir=$(pwd)
cd ~
ln -sfn "$curdir"/tmux.conf .tmux.conf
ln -sfn "$curdir"/bash_aliases .bash_aliases # ensure that .bashrc loads this
ln -sfn "$curdir"/bashrc .bashrc
ln -sfn "$curdir"/neovim/init.vim .config/nvim/init.vim
ln -sfn "$curdir"/flake8 .config/flake8
cd "$curdir"

# configure git
git config --global user.name "Bren Moushall"
git config --global user.email "bmoush@gmail.com"
git config --global push.default simple
git config --global color.ui auto
