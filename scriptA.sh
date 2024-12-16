#!/bin/bash

set -a
source .env
set +a

IMAGE_NAME="$IMAGE_NAME"
CONTAINER_PREFIX="srv"
PORTS=(8001 8002 8003)
CPU_CORES=(0 1 2)
IDLE_THRESHOLD=120
BUSY_THRESHOLD=120
UPDATE_CHECK_INTERVAL=10

start_container() {
  local name=$1
  local port=$2
  local core=$3
  docker run -d --name "$name" --cpuset-cpus="$core" -p "$port:8000" "$IMAGE_NAME" > /dev/null
  echo "Started $name on CPU core #$core (Port: $port)"
}

stop_container() {
  local name=$1
  echo "Stopping $name..."
  docker kill --signal=SIGINT "$name"
  docker wait "$name"
  docker rm "$name"
}

monitor_containers() {
  local idle_time=0
  local busy_time=0

  while true; do
    for i in "${!PORTS[@]}"; do
      local container_name="${CONTAINER_PREFIX}$((i + 1))"
      local next_container="${CONTAINER_PREFIX}$((i + 2))"
      local port="${PORTS[i]}"
      local core="${CPU_CORES[i]}"

      if [ "$(docker ps -q -f name="$container_name")" ] && ! docker ps --filter "name=$next_container" --format '{{.Names}}' | grep -q "$next_container"; then
        CPU_USAGE=$(docker stats --no-stream --format "{{.CPUPerc}}" "$container_name" | tr -d '%')

        if (( $(echo "$CPU_USAGE > 10" | bc) )); then
          busy_time=$((busy_time + UPDATE_CHECK_INTERVAL))
          idle_time=0
        else
          idle_time=$((idle_time + UPDATE_CHECK_INTERVAL))
          busy_time=0
        fi
        if [ "$busy_time" -ge "$BUSY_THRESHOLD" ] && [ $((i + 1)) -lt ${#PORTS[@]} ]; then
          local next_port="${PORTS[i + 1]}"
          local next_core="${CPU_CORES[i + 1]}"

          start_container "$next_container" "$next_port" "$next_core"
          busy_time=0
          idle_time=0
        fi

        if [ "$idle_time" -ge "$IDLE_THRESHOLD" ] && [ $i -gt 0 ]; then
          stop_container "$container_name"
          busy_time=0
          idle_time=0
        fi
      fi
    done

    echo "Checking for updates..."
    pullResult=$(docker pull "$IMAGE_NAME" | grep "Downloaded newer image")

    if [ "$pullResult" ]; then
      echo "New image downloaded. Restarting containers..."

      for i in "${!PORTS[@]}"; do
        local container_name="${CONTAINER_PREFIX}$((i + 1))"
        local port="${PORTS[i]}"
        local core="${CPU_CORES[i]}"

        if [ "$(docker ps -q -f name="$container_name")" ]; then
          stop_container "$container_name"
          start_container "$container_name" "$port" "$core"
        fi
      done
    else
      echo "No updates available."
    fi

    sleep "$((UPDATE_CHECK_INTERVAL))"
  done
}

start_container "${CONTAINER_PREFIX}1" "${PORTS[0]}" "${CPU_CORES[0]}"

monitor_containers
