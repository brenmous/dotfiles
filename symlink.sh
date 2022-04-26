curdir=$(pwd)
cd ~
ln -sfn "$curdir"/conf/tmux.conf .tmux.conf
ln -sfn "$curdir"/conf/bash_aliases .bash_aliases
ln -sfn "$curdir"/conf/bashrc .bashrc
ln -sfn "$curdir"/conf/nvim .config/
cd "$curdir"

