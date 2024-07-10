import os
import zipfile

# Define the directory where your zip files are located
ZIP_DIR = "annotations"

# Ensure the directory exists
if not os.path.isdir(ZIP_DIR):
    print(f"Error: Directory {ZIP_DIR} not found.")
    exit(1)

# List the zip files before changing the directory
zip_files = [f for f in os.listdir(ZIP_DIR) if f.endswith('.zip')]

# Move into the directory containing the zip files
os.chdir(ZIP_DIR)

# Loop through each zip file
for zip_file in zip_files:
    # Extract the contents of the zip file
    with zipfile.ZipFile(zip_file, 'r') as zip_ref:
        zip_ref.extractall(os.path.splitext(zip_file)[0])

    # Optionally, you can remove the zip file after extraction
    os.remove(zip_file)

# Optional: Notify user that extraction is complete
print("Extraction of zip files completed.")
