#!/bin/bash

set -e

# Install all required snaps
declare -a snaps=(
  "bitwarden"
  "gimp"
  "irccloud-desktop"
  "journey"
  "lxd"
  "spotify"
  "vscode"
  "vlc"
)

for item in ${snaps[@]}; do
  if $item == "vscode"
    sudo snap install $item --classic
  else
    sudo snap install $item
  fi
done


# Install all required apt packages
sudo apt-get update

declare -a apts=(
  "ack-grep"
  "bash-completion"
  "chrome-gnome-shell"
  "curl"
  "docker-compose"
  "git"
  "gnome-tweak-tool"
  "python3.6"
  "python3-pip"
  "python3-venv"
  "tmux"
  "vim"
  "wget"
  "zsh"
)

for item in ${apts[@]}; do
  sudo apt-get install $item -y
done


# Install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
source ~/.nvm/nvm.sh
nvm install --lts


# Install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install --no-install-recommends yarn -y


# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ${whoami}


# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb


# Clone and symlink dotfiles
git clone git@github.com:steverydz/dotfiles ~/.dotfiles

declare -a dotfiles=(
  ".ackrc"
  ".aliases"
  ".bash_profile"
  ".bashrc"
  ".functions"
  ".gitconfig"
  ".gitignore"
  ".inputrc"
  ".screenlayout"
  ".tmux.conf"
  ".vimrc"
)

for item in ${dotfiles[@]}; do
  rm -rf ~/$item
  ln -s ~/.dotfiles/$item ~/$item
done

source ~/.bashrc
