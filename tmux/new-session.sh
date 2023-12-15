#!/bin/bash

if [[ $(pwd) != ~ ]]; then
  selected=$(find ~/work ~/dev ~/dotfiles -maxdepth 4 -mindepth 1 -type d | fzf)
else
  selected=$(find ~ -maxdepth 2 -mindepth 1 -type d | fzf)
fi

# exit if no directory is selected
if [[ -z "$selected" ]]; then
  exit 0
fi

read -p "Session name: " session_name

tmux new-session -d -c "$selected" -s "$session_name"

tmux switch-client -t "$session_name"
