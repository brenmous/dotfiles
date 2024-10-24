#! /bin/bash

# Config

mkdir -p "$HOME"/.config
mkdir -p "$HOME"/.docker
ln -sfn "$(pwd)"/private/vars.sh "$HOME"/.private_vars
ln -sfn "$(pwd)"/nvim/nvim "$HOME"/.config/
ln -sfn "$(pwd)"/tmux/tmux.conf "$HOME"/.tmux.conf
ln -sfn "$(pwd)"/docker/config.json "$HOME"/.docker
ln -sfn "$(pwd)"/bash/bashrc "$HOME"/.bashrc
ln -sfn "$(pwd)"/bash/bash_aliases "$HOME"/.bash_aliases

# Scripts
sudo ln -sfn "$(pwd)"/scripts/git_review /usr/local/bin/grev
sudo ln -sfn "$(pwd)"/scripts/mon /usr/local/bin/mon
