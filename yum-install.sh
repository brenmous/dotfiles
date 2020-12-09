#!/bin/bash
# Tested on CentOS 7
set -euo pipefail 

sudo yum -y install epel-release
sudo yum -y update
sudo yum -y install \
    tmux \
    git \
    snapd \
    python3 \
    python-pip

sudo python3 -m pip install -U pip
sudo python -m pip install -U pip
python -m pip instal virtualenv
sudo python -m pip install -U virtualenv

# Need snap for neovim
sudo systemctl enable --now snapd.socket
sudo ln -sfn /var/lib/snapd/snap /snap
sudo snap install nvim --classic
# Update to latest image
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o /tmp/nvim.appimage
sudo mv /tmp/nvim.appimage /usr/local/bin/nvim
chmod u+x /usr/local/bin/nvim

# venv dir
mkdir -p ~/.venvs

# neovim 
mkdir -p ~/.config/nvim

# neovim venvs
python3 -m venv ~/.venvs/nvim3
# Turn off -u because there's an unset $1 in activate script for same raisin
set +u
. ~/.venvs/nvim3/bin/activate
pip install pynvim
deactivate
set -u

python2 -m virtualenv ~/.venvs/nvim2
. ~/.venvs/nvim2/bin/activate
pip install pynvim
deactivate

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# link to dotfiles
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
. /etc/bash_completion.d/git
