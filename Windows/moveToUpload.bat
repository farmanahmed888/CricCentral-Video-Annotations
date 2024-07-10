@echo off

REM Define directories
set ANNOTATIONS_DIR=.\annotations
set UPLOAD_DIR=.\upload

REM Ensure the annotations directory exists
if not exist "%ANNOTATIONS_DIR%" (
    echo Error: Directory %ANNOTATIONS_DIR% not found.
    exit /b 1
)

REM Ensure the upload directory exists
if not exist "%UPLOAD_DIR%" (
    echo Creating directory: %UPLOAD_DIR%
    mkdir "%UPLOAD_DIR%"
)

REM Move video* directories to upload directory
echo Moving video* directories from %ANNOTATIONS_DIR% to %UPLOAD_DIR%
for /d %%d in ("%ANNOTATIONS_DIR%\video*") do (
    move "%%d" "%UPLOAD_DIR%"
)

echo Move operation completed.
