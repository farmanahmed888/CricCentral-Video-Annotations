@echo off
setlocal enabledelayedexpansion

REM Loop through each folder matching the pattern video0*
for /d %%d in (video0*) do (
    REM Extract folder name
    set "folder_name=%%~nd"

    REM Set output file name
    set "output_file=%%d\!folder_name!.mp4"

    REM Combine images into video using ffmpeg
    ffmpeg -y -framerate 30 -pattern_type glob -i "%%d\obj_train_data\*.PNG" -c:v libx264 -pix_fmt yuv420p "!output_file!"
)

endlocal
