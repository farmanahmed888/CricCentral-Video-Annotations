import os
import subprocess

# Loop through each folder
for folder in os.listdir('.'):
    if folder.startswith('video0') and os.path.isdir(folder):
        # Extract folder name
        folder_name = os.path.basename(folder)

        # Set output file name
        output_file = os.path.join(folder, f"{folder_name}.mp4")

        # Combine images into video using ffmpeg
        cmd = [
            'ffmpeg', '-y', '-framerate', '30', '-pattern_type', 'glob', 
            '-i', f"{folder}/obj_train_data/*.PNG", 
            '-c:v', 'libx264', '-pix_fmt', 'yuv420p', output_file
        ]
        subprocess.run(cmd)

        print(f"Created video {output_file}")
