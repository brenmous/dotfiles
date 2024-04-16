#!/bin/bash

# starting from a minimal install of Ubuntu 22.04 desktop

set -e 

curdir=$(pwd)

echo "Updating ubuntu"
sudo apt update && sudo apt upgrade

echo "Installing required packages"
sudo apt install git \
    curl \
    gcc \
    software-properties-common \
    xclip \
    nodejs \
    npm \
    gnupg \
    ca-certificates \
    python3-pip \
    pipx

echo "Installing nvim nightly"
../common/install-nvim.sh

echo "Updating pip and setuptools"
python3 -m pip install -U pip setuptools

echo "Installing quickenv"
pipx install git+https://github.com/brenmous/quickenv

echo "Installing pyright"
pipx install pyright

echo "Installing pyneac"
pipx install git+https://bitbucket.org/geoscienceaustralia/pyneac

echo "Installing vscode language servers"
sudo npm i -g vscode-langservers-extracted

echo "Installing tmux"
sudo apt install tmux

echo "Adding hashicorp repos"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update 

echo "Installing terraform"
sudo apt install terraform

echo "Installing packer"
sudo apt install packer

echo "Installing docker"
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Installing amazon-ecr-credential-helper"
sudo apt install amazon-ecr-credential-helper

echo "Linking config files"
./symlink.sh

echo "Configuring git"
git config --global user.name "Bren Moushall"
git config --global user.email "bmoush@gmail.com"
git config --global push.default simple
git config --global color.ui auto

# below requires keys to be setup
echo "Pull notes"
../common/note_taking/pull-notes.sh
