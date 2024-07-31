#!/bin/bash

services=( traefik taiko-web litey stats )

for service in ${services[@]}; do
  (
    cd "../docker/$service"
    tmux kill-session -t "$service"
    tmux new-session -s "$service" -d
    tmux send-keys -t "$service" "while true; do docker compose down; docker compose up --abort-on-container-exit; done" C-m
  )
done
