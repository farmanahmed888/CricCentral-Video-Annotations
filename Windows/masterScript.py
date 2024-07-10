import os
import shutil
import zipfile
import subprocess

def rename_annotations():
    # Implement the logic of renameAnnotations.py
    print("Step 1: Renaming annotations...")
    subprocess.run(['python3', 'renameAnnotations.py'], check=True)

def unzip_files():
    # Implement the logic of unzipAnnotations.py
    print("Step 2: Unzipping annotations...")
    subprocess.run(['python3', 'unzipAnnotations.py'], check=True)

def move_to_upload():
    # Implement the logic of moveToUpload.py
    print("Step 3: Moving to upload...")
    subprocess.run(['python3', 'moveToUpload.py'], check=True)

def convert_to_video():
    # Implement the logic of convertToVideo.py
    print("Step 4: Converting to video in upload...")
    os.chdir('./upload')
    subprocess.run(['python3', 'convertToVideo.py'], check=True)
    os.chdir('../')

def run_visualize_creator():
    # Implement the logic of visualizeCreator.py
    print("Step 5: Running visualizeCreator.py...")
    subprocess.run(['python3', 'visualizeCreator.py'], check=True)

def rename_files_in_csvs():
    # Implement the logic of rename_files.py in csvs directory
    print("Step 6: Renaming files in upload/csvs...")
    os.chdir('./upload/csvs')
    subprocess.run(['python3', 'rename_files.py'], check=True)
    os.chdir('../../')

def rename_files_in_videos():
    # Implement the logic of rename_files.py in videos directory
    print("Step 7: Renaming files in upload/videos...")
    os.chdir('./upload/videos')
    subprocess.run(['python3', 'rename_files.py'], check=True)
    os.chdir('../../')

def main():
    rename_annotations()
    unzip_files()
    move_to_upload()
    convert_to_video()
    run_visualize_creator()
    rename_files_in_csvs()
    rename_files_in_videos()
    print("Master script completed.")

if __name__ == "__main__":
    main()
