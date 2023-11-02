curdir=$(pwd)
cd ~
mkdir -p .config
mkdir -p .docker
ln -sfn "$curdir"/../common/conf/tmux.conf .tmux.conf
ln -sfn "$curdir"/conf/bash_aliases .bash_aliases
ln -sfn "$curdir"/conf/bashrc .bashrc
ln -sfn "$curdir"/../common/conf/nvim .config/
ln -sfn "$curdir"/conf/docker/config.json .docker/
cd "$curdir"

