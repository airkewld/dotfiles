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

tmux has-session -t "🧔🏻‍♂️" 2> /dev/null || TMUX='' tmux new-session -d -c "$selected" -s "🧔🏻‍♂️"

if [[ -z "$TMUX" ]];
then
  tmux attach-session -d -t 🧔🏻‍♂️
else
  tmux new-window -c "$selected" '/opt/homebrew/bin/nvim .'
fi
