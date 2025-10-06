#!/bin/bash

start=$1  # Starting number (first argument)
end=$2    # Ending number or last iteration (second argument)

if [ -z "$start" ] || [ -z "$end" ]; then
  echo "Usage: $0 <starting_number> <ending_number>"
  exit 1
fi

for ((i=start; i<=end; i++)); do
  if [ $i -eq $end ]; then
    echo "Sequence complete! Iterations from $start to $end."
  fi
done