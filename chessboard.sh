#!/bin/bash

# Function to print the chessboard
print_chessboard() {
    for ((i = 1; i <= 8; i++)); do
        for ((j = 1; j <= 8; j++)); do
            if (( (i + j) % 2 == 0 )); then
                echo -n "██"
            else
                echo -n "  "
            fi
        done
        echo    # Move to the next line
    done
}

# Call the function to print the chessboard
print_chessboard
