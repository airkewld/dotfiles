#!/bin/bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~ -maxdepth 2 -mindepth 1 -type d | fzf)
fi

tmux has-session -t "🧔🏻‍♂️" 2> /dev/null || TMUX='' tmux new-session -d -c "$selected" -s "🧔🏻‍♂️"

if [[ -z "$TMUX" ]];
then
tmux attach-session -d -t 🧔🏻‍♂️
else
tmux new-window -c "$selected"
fi
