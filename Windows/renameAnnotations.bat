@echo off

REM Specify the relative directory containing the files
set directory=.\annotations

REM Go to the directory
cd "%directory%" || (
    echo Directory not found
    exit /b 1
)

REM Loop through each file matching the pattern
for %%f in (task_video*.zip) do (
    if exist "%%f" (
        REM Extract the numeric part from the filename
        for /f "tokens=1 delims=_" %%a in ("%%~nf") do (
            for /f "tokens=2 delims=_" %%b in ("%%~nf") do (
                set "number=%%b"
            )
        )
        call :renameFile "%%f" "%number%"
    )
)
exit /b

:renameFile
    setlocal
    set "file=%~1"
    set "number=%~2"
    echo %number%
    if defined number (
        REM Rename the file
        rename "%file%" "video%number%.zip"
        echo Renamed %file% to video%number%.zip
    ) else (
        echo Failed to extract number from %file%
    )
    endlocal
    exit /b
