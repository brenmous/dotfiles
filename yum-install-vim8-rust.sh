#!/bin/bash
sudo yum -y install epel-release
sudo yum -y update
sudo yum -y install tmux
sudo yum -y install python-pip
sudo yum -y install zip
sudo yum -y install unzip

# Rust
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
rustup update

# install terraform
sudo curl -L https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip \
        -o /usr/tmp/terraform.zip
sudo unzip /usr/tmp/terraform -d /usr/bin
sudo rm /usr/tmp/terraform.zip


# configure git
git config --global user.name "Bren Moushall"
git config --global user.email "bmoush@gmail.com"
git config --global push.default simple
git config --global color.ui auto
. /etc/bash_completion.d/git

# VIM
cd /home/centos/.vim/
mkdir -p pack/plugins/start

# Plugins
git clone https://github.com/w0rp/ale.git ~/.vim/pack/plugins/start/ale
git clone https://github.com/rust-lang/rust.vim ~/.vim/pack/plugins/start/rust.vim

# link to the dot files
curdir=`pwd`
cd ~
ln -fs "$curdir"/vimrc .vimrc
ln -fs "$curdir"/tmux.conf .tmux.conf
ln -fs "$curdir"/bash_aliases .bash_aliases # ensure that .bashrc loads this
ln -fs "$curdir"/bashrc .bashrc
cd "$curdir"

