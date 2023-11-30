# Define shell
SHELL := /bin/bash

# Phony targets
.PHONY: all brew neovim ansible npm-packages bootstrap-playbook pre-commit

# Default target
all: brew neovim ansible npm-packages bootstrap-playbook pre-commit

# Install Homebrew
brew:
	@if ! which brew > /dev/null; then \
		echo "Installing homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	else \
		echo "homebrew already installed."; \
	fi; \
	brew install npm > /dev/null

# Install Neovim
neovim:
	@if ! which nvim > /dev/null; then \
		echo "Installing neovim..."; \
		brew install neovim; \
		brew link neovim; \
	else \
		echo "neovim already installed."; \
	fi

# Install Ansible
ansible:
	@if ! which ansible > /dev/null; then \
		echo "installing ansible..."; \
		pip3 install ansible; \
	else \
		echo "ansible already installed."; \
	fi

# Install npm packages
npm-packages:
	npm install -g dockerfile-language-server-nodejs vim-language-server

# Run playbook
bootstrap-playbook:
	git pull
	ansible-playbook config.yaml --diff

# Install pre-commit hooks
pre-commit:
	pre-commit install

# Updates
update:
	git pull
	ansible-playbook config.yaml --diff -t always
