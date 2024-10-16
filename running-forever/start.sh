#!/bin/bash

services=( traefik taiko-web litey stats )

args=("${@:-"${services[@]}"}")

for service in "${args[@]}"; do
  echo "$service を再起動しています…"
  (
    cd "../docker/$service"
    tmux kill-session -t "$service"
    tmux new-session -s "$service" -d
    tmux send-keys -t "$service" "while true; do docker compose down; docker compose up --abort-on-container-exit; done" C-m
  )
done
