#!/bin/bash

# Loop through each folder
for folder in video0*; do
    # Extract folder name
    folder_name=$(basename "$folder")

    # Set output file name
    output_file="${folder}/${folder_name}.mp4"

    # Combine images into video using ffmpeg
    ffmpeg -y -framerate 30 -pattern_type glob -i "${folder}/obj_train_data/*.PNG" -c:v libx264 -pix_fmt yuv420p "${output_file}"
done
