#!/bin/bash
duration=30
# Set the duration in seconds
# Get the start time
start_time=$(date +%s)

echo "starting loadtest"
# Loop until the specified duration is reached
while [ $(($(date +%s) - $start_time)) -lt $duration ]
do
    # Perform a computationally intensive task
    # Here, we use a mathematical calculation to generate CPU load
    result=$(echo "scale=5000; 4*a(1)" | bc -lq)
done
echo "done loadtest"