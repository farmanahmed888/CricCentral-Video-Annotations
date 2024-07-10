import os
import shutil

# Define directories
ANNOTATIONS_DIR = "./annotations"
UPLOAD_DIR = "./upload"

# Ensure the annotations directory exists
if not os.path.isdir(ANNOTATIONS_DIR):
    print(f"Error: Directory {ANNOTATIONS_DIR} not found.")
    exit(1)

# Ensure the upload directory exists
if not os.path.isdir(UPLOAD_DIR):
    print(f"Creating directory: {UPLOAD_DIR}")
    os.makedirs(UPLOAD_DIR)

# Move video* directories to upload directory
print(f"Moving video* directories from {ANNOTATIONS_DIR} to {UPLOAD_DIR}")
for item in os.listdir(ANNOTATIONS_DIR):
    if item.startswith('video') and os.path.isdir(os.path.join(ANNOTATIONS_DIR, item)):
        shutil.move(os.path.join(ANNOTATIONS_DIR, item), UPLOAD_DIR)

print("Move operation completed.")
