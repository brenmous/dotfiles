#!/bin/bash
# Update to latest nvim image
set -e

curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o /tmp/nvim.appimage
sudo mv /tmp/nvim.appimage /usr/local/bin/nvim
chmod u+x /usr/local/bin/nvim
