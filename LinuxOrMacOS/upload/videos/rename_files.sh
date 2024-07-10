#!/bin/bash

# Prompt the user to enter the starting index for new file names
read -p "Enter the starting index for new file names: " new_index


# Loop through all files matching the pattern video*_ball.csv
for old_file in video*.mp4; 
do
    # Extract the old index from the file name
    old_index=$(echo $old_file | grep -o -E '[0-9]+')

    # Construct the new file name
    new_file="video${new_index}.mp4"

    # Rename the file
    mv "$old_file" "$new_file"

    echo "Renamed $old_file to $new_file"

    # Increment the new index for the next file
    ((new_index++))
done
