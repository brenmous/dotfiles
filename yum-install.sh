curdir=`pwd`
#!/bin/bash
sudo yum -y install epel-release
sudo yum -y update
sudo yum -y install tmux
sudo yum -y install python-pip
sudo yum -y install zip
sudo yum -y install unzip

# Rust
#curl https://sh.rustup.rs -sSf | sh
#source $HOME/.cargo/env
#rustup update
#sudo yum -y install openssl-devel
#sudo yum -y install cmake

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
sudo yum -y install ncurses-devel
cd /usr/tmp
git clone https://github.com/vim/vim
cd vim
make
make install
cd $curdir
mkdir -p ~/.vim/pack/plugins/start
# Plugins
git clone https://github.com/w0rp/ale.git ~/.vim/pack/plugins/start/ale
#git clone https://github.com/rust-lang/rust.vim ~/.vim/pack/plugins/start/rust.vim

# link to the dot files
ln -fs "$curdir"/vim8/vimrc ~/.vimrc
ln -fs "$curdir"/tmux.conf ~/.tmux.conf
ln -fs "$curdir"/bash_aliases ~/.bash_aliases # ensure that .bashrc loads this
ln -fs "$curdir"/bashrc ~/.bashrc

