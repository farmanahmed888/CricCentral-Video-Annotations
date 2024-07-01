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
