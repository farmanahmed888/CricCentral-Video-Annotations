@echo off

REM Define the directory where your zip files are located
set ZIP_DIR=.\annotations

REM Ensure the directory exists
if not exist "%ZIP_DIR%" (
    echo Error: Directory %ZIP_DIR% not found.
    exit /b 1
)

REM Move into the directory containing the zip files
cd "%ZIP_DIR%" || exit /b

REM Loop through each zip file
for %%f in (*.zip) do (
    REM Extract the contents of the zip file
    "%ProgramFiles%\7-Zip\7z.exe" x "%%f" -o"%%~nf" -y

    REM Optionally, you can remove the zip file after extraction
    del "%%f"
)

REM Optional: Notify user that extraction is complete
echo Extraction of zip files completed.
