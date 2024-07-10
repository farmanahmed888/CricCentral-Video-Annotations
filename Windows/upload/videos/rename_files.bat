@echo off
setlocal enabledelayedexpansion

REM Prompt the user to enter the starting index for new file names
set /p new_index="Enter the starting index for new file names: "

REM Loop through all files matching the pattern video*.mp4
for %%f in (video*.mp4) do (
    REM Extract the old index from the file name
    for /f "tokens=2 delims=o." %%i in ("%%~nf") do (
        set old_index=%%i
    )

    REM Construct the new file name
    set new_file=video!new_index!.mp4

    REM Rename the file
    ren "%%f" "!new_file!"

    echo Renamed %%f to !new_file!

    REM Increment the new index for the next file
    set /a new_index+=1
)

endlocal
