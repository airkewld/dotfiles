#!/bin/bash

## Install packages needed to build local config
# Brew
if ! which brew
then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "homebrew already installed."
fi

# Neovim
if ! which nvim
then
  echo "Installing neovim..."
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
else
  echo "neovim already installed."
fi

# ansible
if ! which ansible
then
  echo "installing ansible..."
  brew install ansible
else
  echo "ansible already installed."
fi

# oh-my-zsh
if ! stat /Users/oscarr/.oh-my-zsh
then
  echo "Installing oh-my-zsh..."
  /bin/bash  -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "oh-my-zsh already installed."
fi

npm install -g dockerfile-language-server-nodejs vim-language-server

## Run playbook
ansible-playbook config.yaml --diff

# pre-commit
pre-commit install
