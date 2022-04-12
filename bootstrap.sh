#!/bin/bash

# Brew
if ! which brew > /dev/null
then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "homebrew already installed."
fi

# Neovim
# if ! which nvim > /dev/null
# then
#   echo "Installing neovim..."
#   brew install neovim
#   brew link neovim
# else
#   echo "neovim already installed."
# fi

# ansible
if ! which ansible > /dev/null
then
  echo "installing ansible..."
  brew install ansible
else
  echo "ansible already installed."
fi


# npm install -g dockerfile-language-server-nodejs vim-language-server

## Run playbook
ansible-playbook config.yaml --diff --ask-vault-pass

# pre-commit
pre-commit install
