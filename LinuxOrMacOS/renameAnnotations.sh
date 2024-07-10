#!/bin/bash

# Specify the relative directory containing the files
directory="./annotations"

# Go to the directory
cd "$directory" || { echo "Directory not found"; exit 1; }

# Loop through each file matching the pattern
for file in task_video*.zip; do
    if [ -f "$file" ]; then
        # Extract the numeric part from the filename
        number=$(echo "$file" | grep -oE '[0-9]+' | head -1)
        echo "${number}"
        if [ -n "$number" ]; then
            # Rename the file
            mv "$file" "video${number}.zip"
            echo "Renamed $file to video${number}.zip"
        else
            echo "Failed to extract number from $file"
        fi
    fi
done
