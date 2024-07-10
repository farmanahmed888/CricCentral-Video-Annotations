@echo off

REM Step 1: Change directory to annotations and run renameAnnotations.bat
echo Step 1: Renaming annotations...
call renameAnnotations.bat

REM Step 2: Unzip files in annotations
echo Step 2: Unzipping annotations...
call unzipAnnotations.bat

REM Step 3: Move contents to upload directory
echo Step 3: Moving to upload...
call moveToUpload.bat

REM Step 4: Change directory to upload and convert to video
echo Step 4: Converting to video in upload...
cd upload || exit /b
call convertToVideo.bat
cd ..

REM Step 5: Run visualizeCreator.py
echo Step 5: Running visualizeCreator.py...
python visualizeCreator.py

REM Step 6: Change directory to upload/csvs and run rename_files.bat
echo Step 6: Renaming files in upload/csvs...
cd upload\csvs || exit /b
call rename_files.bat
cd ..\..

REM Step 7: Change directory to upload/videos and run rename_files.bat
echo Step 7: Renaming files in upload/videos...
cd upload\videos || exit /b
call rename_files.bat
cd ..\..

echo Master script completed.
