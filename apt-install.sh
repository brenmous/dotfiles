#!/bin/bash
set -euxo pipefail


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

# Need to add node.js for coc.nvim
curl -L install-node.now.sh -o /tmp/install-node.sh 
chmod u+rwx /tmp/install-node.sh
sudo /tmp/install-node.sh -y
rm /tmp/install-node.sh

# venv dir
mkdir -p ~/.venvs

# vim 8
#sudo add-apt-repository ppa:jonathonf/vim -y
#sudo apt-get install vim
#mkdir -p ~/.vim/pack/plugins/start
#git clone https://github.com/w0rp/ale.git ~/.vim/pack/plugins/start/ale
#git clone https://github.com/rust-lang/rust.vim ~/.vim/pack/plugins/start/rust.vim

# neovim
mkdir -p ~/.config/nvim

python3.7 -m venv ~/.venvs/nvim37
. ~/.venvs/nvim37/bin/activate
pip install pynvim
deactivate

python2.7 -m virtualenv ~/.venvs/nvim27
. ~/.venvs/nvim27/bin/activate
pip install pynvim
deactivate

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# link to the dot files
curdir=`pwd`
cd ~
ln -sfn "$curdir"/vim8/vimrc .vimrc
ln -sfn "$curdir"/tmux.conf .tmux.conf
ln -sfn "$curdir"/bash_aliases .bash_aliases # ensure that .bashrc loads this
ln -sfn "$curdir"/bashrc .bashrc
ln -sfn "$curdir"/neovim/init.vim .config/nvim/init.vim
ln -sfn "$curdir"/neovim/coc-settings.json .config/nvim/coc-settings.json
cd "$curdir"

# configure git
git config --global user.name "Bren Moushall"
git config --global user.email "bmoush@gmail.com"

# pull notes
chmod u+rx scripts/note
chmod u+rx scripts/notesync
cd ~
git clone git@github.com:brenmous/notes
cd "$curdir"
