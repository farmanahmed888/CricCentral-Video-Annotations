import os
import re

# Prompt the user to enter the starting index for new file names
new_index = int(input("Enter the starting index for new file names: "))

# Loop through all files matching the pattern video*.mp4
for old_file in os.listdir('.'):
    if old_file.startswith('video') and old_file.endswith('.mp4'):
        # Extract the old index from the file name
        old_index = re.search(r'\d+', old_file).group()

        # Construct the new file name
        new_file = f"video{new_index}.mp4"

        # Rename the file
        os.rename(old_file, new_file)

        print(f"Renamed {old_file} to {new_file}")

        # Increment the new index for the next file
        new_index += 1
