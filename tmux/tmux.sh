#!/bin/bash
set -x
if tmux ls | grep DSO;
then
tmux attach-session -d -t DSO
else
tmux new-session -d -s DSO
tmux new-window -d -c ~/work/devsecops
tmux attach-session -d -t DSO
fi
