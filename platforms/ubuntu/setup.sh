#!/bin/bash

# starting from a minimal install of Ubuntu 22.04 desktop

set -e

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
    pipx \
    tmux

echo "Installing nvim nightly"
../common/install-nvim.sh

echo "Updating pip and setuptools"
python3 -m pip install -U pip

echo "Installing uv"
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "Adding hashicorp repos"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update

echo "Installing terraform, packer"
sudo apt install terraform packer

echo "Installing docker"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker "$USER"
newgrp docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo apt install amazon-ecr-credential-helper

echo "Linking config files"
../../symlink.sh

echo "Configuring git"
git config --global user.name "Brenainn Moushall"
git config --global user.email "$MY_EMAIL"
git config --global push.default simple
git config --global color.ui auto
