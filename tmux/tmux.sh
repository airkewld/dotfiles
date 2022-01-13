#!/bin/bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/work/dso ~/work/armed -maxdepth 1 -mindepth 1 -type d | fzf)
fi

tmux has-session -t "DSO" 2> /dev/null || TMUX='' tmux new-session -d -c "$selected" -s "DSO"

if [[ -z "$TMUX" ]];
then
tmux attach-session -d -t DSO
else
tmux new-window -d -c "$selected"
fi
