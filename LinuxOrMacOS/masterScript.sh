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
