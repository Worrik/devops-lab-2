#!/bin/bash

SERVER_URL="http://localhost"

make_request() {
  while true; do
    sleep $((RANDOM % 6 + 5))
    curl -s "$SERVER_URL" > /dev/null &
    echo "Made a request to $SERVER_URL at $(date)"
  done
}

for i in {1..5}; do
  make_request &
done

wait
