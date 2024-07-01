#!/bin/bash

# Define the directory where your zip files are located
ZIP_DIR="./annotations"

# Ensure the directory exists
if [ ! -d "$ZIP_DIR" ]; then
    echo "Error: Directory $ZIP_DIR not found."
    exit 1
fi

# Move into the directory containing the zip files
cd "$ZIP_DIR" || exit

# Loop through each zip file
for zip_file in *.zip; do
    # Extract the contents of the zip file
    unzip -o "$zip_file" -d "${zip_file%.zip}"

    # Optionally, you can remove the zip file after extraction
    rm "$zip_file"
done

# Optional: Notify user that extraction is complete
echo "Extraction of zip files completed."
