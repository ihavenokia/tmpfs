#!/bin/bash

# Function to display countdown
countdown() {
    secs=$1
    while [ $secs -gt 0 ]; do
        printf "\rNext request in %02d seconds. Press 'q' to quit." $secs
        sleep 1
        : $((secs--))
    done
    printf "\n"
}

# Function to prompt for interval input
prompt_interval() {
    read -p "Enter interval in seconds: " interval
    if ! [[ "$interval" =~ ^[0-9]+$ ]]; then
        echo "Error: Please enter a valid integer."
        prompt_interval
    fi
}

# Main function
main() {
    prompt_interval
    while true; do
        # Make the curl request
        curl -X 'GET' 'http://localhost:5000/File?sInputPath=%2Fhome%2Fadminlocal%2Fapi%2Fteste.pdf&sTargetPath=%2Fmnt%2FNASShare%2FtesteFromLinux.pdf' -H 'accept: */*' >/dev/null &
        
        # Display countdown until next request
        countdown "$interval" &

        # Wait for user input or the interval
        read -n 1 -t "$interval" input
        if [ "$input" = "q" ]; then
            printf "\nStopped.\n"
            break
        fi
    done
}

# Start the script
main
