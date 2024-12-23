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

echo "Installing vscode langservers"
npm i -g vscode-langservers-extracted

echo "Installing tmux"
sudo pacman -S --noconfirm tmux

echo "Installing terraform"
yay -S community/terraform

echo "Installing packer"
yay -S community/packer

echo "Installing docker"
sudo pacman -S docker

echo "Installing aws-cli"
pip install aws-cli

echo "Installing amazon-ecr-credential-helper"
yay -S aur/amazon-ecr-credential-helper

echo "Installing cmake"
sudo pacman -S cmake extra-cmake-modules

echo "Linking config files"
./symlink.sh

echo "Configuring git"
git config --global user.name "Bren Moushall"
git config --global user.email "$MY_EMAIL"
git config --global push.default simple
git config --global color.ui auto

echo "Pull notes"
../common/note_taking/pull-notes.sh
