# CVAT Notation Guide
# Table of Contents

1. [Requirements](#requirements) 
2. [File Structure](#file-structure) 
3.  [Enable Python Virtual Environment](#enable-python-virtual-environment) 
4. [Install Dependencies](#install-dependencies) 
5. [Run the Master Script](#run-the-master-script) 
6.  [Upload Files to Drive](#upload-files-to-drive) 
7. [visualizeDetector](#visualizedetector) 
8. [Script Details](#script-details) 
	- [Master Script](#master-script)
	 - [Rename Annotations](#rename-annotations) 
	 - [Unzip Annotations](#unzip-annotations) 
	 - [MoveToUpload](#movetoupload) 
	 - [ConvertToVideo](#converttovideo) 
	 - [CSV Rename Files](#csv-rename_files) 
	 - [Video Rename Files](#video-rename_files)
# Requirements
- Python
- Python virtual environment
- Bash
# File Structure
```
annotations
upload
├── convertToVideo.sh
├── csvs
│   └── rename_files.sh
├── videos
│   └── rename_files.sh
├── visualizeCreator.py
└── visualizeDetector.py
```
# WARNING
remember to rename the zip files to video* i.e. serially
## Enable Python Virtual Environment

To create python3 environment use 
```
python3 -m venv path/to/venv
```
Activate the environment
```
source path/to/venv/bin/activate
```
Example usage:
```
python3 -m ~/Desktop/workspace
source ~/Desktop/workspace/bin/activate
```

## Install Dependencies

```
pip install opencv-python
OR
pip3 install opencv-python
```
## For Ubuntu
```
sudo apt install ffmpeg
```
## Install openCV
```
pip install opencv-python
```

## Run the Master Script
```
chmod +x masterScript.sh
./masterScript.sh
```

## Upload files to drive

```
Go to Directory
workspace
├── csvs
│   └── *
```
upload all files except **rename_files.sh**
```
Go to Directory
workspace
├── videos
│   └── *
```
upload all files except **rename_files.sh**

## visualizeDetector

This is used to verify the annotations done correctly. Use it once or twice to understand after that it is not used.


# Script Details
## Master Script
```
#!/bin/bash

# Step 1: Change directory to annotations and run renameAnnotations.sh
echo "Step 1: Renaming annotations..."
chmod +x renameAnnotations.sh
./renameAnnotations.sh

# Step 2: Unzip files in annotations
echo "Step 2: Unzipping annotations..."
chmod +x unzipAnnotations.sh
./unzipAnnotations.sh

# Step 3: Move contents to upload directory
echo "Step 3: Moving to upload..."
chmod +x moveToUpload.sh
./moveToUpload.sh

# Step 4: Change directory to upload and convert to video
echo "Step 4: Converting to video in upload..."
cd ./upload || exit
chmod +x convertToVideo.sh
./convertToVideo.sh
cd ../

# Step 5: Run visualizeCreator.py
echo "Step 5: Running visualizeCreator.py..."
python3 visualizeCreator.py

# Step 6: Change directory to upload/csvs and run rename_files.sh
echo "Step 6: Renaming files in upload/csvs..."
cd ./upload/csvs || exit
chmod +x rename_files.sh
./rename_files.sh
cd ../../

# Step 7: Change directory to upload/videos and run rename_files.sh
echo "Step 7: Renaming files in upload/videos..."
cd ./upload/videos || exit
chmod +x rename_files.sh
./rename_files.sh
cd ../../

echo "Master script completed."

```
## Rename Annotations
```
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

```
## Unzip Annotations
```
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

```
## MoveToUpload
```
#!/bin/bash

# Define directories
ANNOTATIONS_DIR="./annotations"
UPLOAD_DIR="./upload"

# Ensure the annotations directory exists
if [ ! -d "$ANNOTATIONS_DIR" ]; then
    echo "Error: Directory $ANNOTATIONS_DIR not found."
    exit 1
fi

# Ensure the upload directory exists
if [ ! -d "$UPLOAD_DIR" ]; then
    echo "Creating directory: $UPLOAD_DIR"
    mkdir -p "$UPLOAD_DIR"
fi

# Move video* directories to upload directory
echo "Moving video* directories from $ANNOTATIONS_DIR to $UPLOAD_DIR"
mv "$ANNOTATIONS_DIR"/video* "$UPLOAD_DIR"

echo "Move operation completed."

```
## ConvertToVideo
```
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

```
## CSV rename_files
```
#!/bin/bash

# Prompt the user to enter the starting index for new file names
read -p "Enter the starting index for new file names: " new_index

# Loop through all files matching the pattern video*_ball.csv
for old_file in video*_ball.csv; 
do
    # Extract the old index from the file name
    old_index=$(echo $old_file | grep -o -E '[0-9]+')

    # Construct the new file name
    new_file="video${new_index}_ball.csv"

    # Rename the file
    mv "$old_file" "$new_file"

    echo "Renamed $old_file to $new_file"

    # Increment the new index for the next file
    ((new_index++))
done

```
## Video rename_files
```
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

```
