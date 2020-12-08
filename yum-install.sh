#!/bin/bash
# Tested on CentOS 7
set -euxo pipefail 

sudo yum -y install epel-release
sudo yum -y update
sudo yum -y install \
    tmux \
    git \
    snapd \
    python3 \
    python-pip

sudo pip3 install -U pip
sudo pip install -U pip
pip install virtualenv

# Need snap for neovim
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
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
python3 -m venv ~/.venvs/nvim36
. ~/.venvs/nvim36/bin/activate
pip install pynvim
deactivate

python2 -m virtualenv ~/.venvs/nvim27
. ~/.venvs/nvim27/bin/activate
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
ln -sfn "$curdir"/neovim/coc-settings.json .config/nvim/coc-settings.json
ln -sfn "$curdir"/flake8 .config/flake8
cd "$curdir"

# configure git
git config --global user.name "Bren Moushall"
git config --global user.email "bmoush@gmail.com"
git config --global push.default simple
git config --global color.ui auto
. /etc/bash_completion.d/git
