#!/bin/bash

# Ubuntu 24.10

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
    tmux \
    libfuse2t64 \
    golang \
    python3-dev \
    amazon-ecr-credential-helper \
    mysql-server \
    libmysqlclient-dev

echo "Installing awscli"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip /tmp/awscliv2.zip -d /tmp
sudo ./tmp/aws/install

echo "Installing SSM plugin"
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "/tmp/session-manager-plugin.deb"
sudo dpkg -i /tmp/session-manager-plugin.deb

echo "Installing uv"
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "Adding hashicorp repos"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
# echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
# No hashicorp repos for 24.10 yet, use 24.04 (doesn't matter anyway, no difference)
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com noble main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
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
sudo usermod -aG docker "$USER"
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

echo "Configuring git"
git config --global user.name "Brenainn Moushall"
git config --global user.email "$MY_EMAIL"
git config --global push.default simple
git config --global color.ui auto
