#!/bin/bash
#set -x
#if tmux ls | grep DSO;
#then
#tmux attach-session -d -t DSO
#else
#tmux new-session -d -s DSO
#tmux new-window -d -c ~/work/dso
#tmux attach-session -d -t DSO
#fi

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~ ~/work/dso ~/work/armed -maxdepth 1 -mindepth 1 -type d | fzf)
fi

dirname=$(basename "$selected" | tr . _)

# create new tmux session (not nested) only if session
# dosn't exist
tmux has-session -t "$dirname" 2> /dev/null || TMUX='' tmux new-session -d -c "$selected" -s "$dirname"

if [[ -z "$TMUX" ]]; then
    # attach to new session (created in detached mode)
    tmux attach -t "$dirname"
else
    # switch to existing session
    tmux switch-client -t "$dirname"
fi
