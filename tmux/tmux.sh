#!/usr/bin/env bash
#set -x
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~ ~/work/dso ~/work/armed -maxdepth 1 -mindepth 1 -type d | fzf)
fi

if tmux ls | grep DSO;
  then
    tmux attach-session -d -t DSO
  else
    tmux new-session -d -s DSO
    tmux new-window -d -c "$selected"
    tmux attach-session -d -t DSO
fi
