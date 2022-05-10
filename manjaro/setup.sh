#!/bin/bash

set -e 

echo "Updating manjaro"
sudo pacman -Syu

echo "Installing nvim nightly"
../common/install-nvim.sh

echo "Updating pip and setuptools"
python -m pip install -U pip setuptools

echo "Installing quickenv"
pip install git+https://github.com/brenmous/quickenv

echo "Installing pyright"
pip install pyright

echo "Installing tmux"
sudo pacman -S --noconfirm tmux

echo "Linking config files"
./symlink.sh

echo "Configuring git"
git config --global user.name "Bren Moushall"
git config --global user.email "bmoush@gmail.com"
git config --global push.default simple
git config --global color.ui auto

echo "Pull notes"
../common/note_taking/pull-notes.sh
