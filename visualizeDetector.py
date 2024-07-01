import os
import csv
import glob
import cv2
import shutil
import numpy as np
from scipy.ndimage import gaussian_filter1d

dir = "upload/"

def convert_yolo_to_csv(input_folder, output_csv, video):
    with open(output_csv, mode='w', newline='') as csv_file:
        fieldnames = ['Frame', 'Visibility', 'X', 'Y']
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
        writer.writeheader()
        txt_files = sorted(glob.glob(input_folder + "/*.txt"))
        frame_idx = 0
        cap = cv2.VideoCapture(video)
        trajectory = []
        for filename in txt_files:
            ret, frame = cap.read()
            frame = cv2.resize(frame, (720, 1280))
            # print(filename)
            if filename.endswith('.txt'):

                with open(filename, 'r') as txt_file:
                    lines = txt_file.readlines()
                    if len(lines) == 0:
                        visibility = 0
                        x = 0
                        y = 0
                        writer.writerow({'Frame': frame_idx, 'Visibility': visibility, 'X': x, 'Y': y})
                    else:
                        for line in lines:
                            # Parse YOLO format (x, y, w, h)
                            values = list(map(float, line.strip().split()[1:]))
                            x, y, w, h = map(float, values)
                            trajectory.append((x*720,y*1280))
                            # Convert YOLO format to CSV format (frame, visibility, x, y)
                            visibility = 1  # You can modify this based on your data
                            writer.writerow({'Frame': frame_idx, 'Visibility': visibility, 'X': x*720, 'Y': y*1280})
                            cv2.circle(frame, (int(x*720), int(y*1280)), 5, (0, 255, 0), -1)
                    # Display the frame
                    cv2.imshow('Annotated Frame', frame)

                    # Break the loop if 'q' key is pressed
                    if cv2.waitKey(10) & 0xFF == ord('q'):
                        break
            frame_idx += 1
    img = np.zeros((1280, 720, 3))
    trajectory = np.array(trajectory)
    # Parameters
    sigma = 1.0  # Standard deviation for Gaussian kernel

    # trajectory[:, 0] = gaussian_filter1d(trajectory[:, 0], sigma)
    # trajectory[:, 1] = gaussian_filter1d(trajectory[:, 1], sigma)
    print(trajectory)
    
    pts2 = np.column_stack((trajectory[:, 0], trajectory[:, 1]))
    pts2 = pts2.astype(int)

    cv2.polylines(img, [pts2], isClosed=False, color=(0, 255, 0), thickness=2)

    cv2.imshow('', img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

    shutil.copy(output_csv, dir + "/csvs/"+output_csv.rsplit("/",1)[1])

if __name__ == "__main__":
    video_files = glob.glob(dir + "/**/*.mp4")
    video_files = [directory for directory in video_files if "videos" not in directory]
    video_files =sorted(video_files)
    print(video_files)
    os.makedirs(dir + "/videos", exist_ok=True)
    os.makedirs(dir + "/csvs", exist_ok=True)
    count = 1
    for i in video_files[4:]:
        input_folder = i.rsplit("/",1)[0]+"/obj_train_data/"  # Replace with the path to your folder containing YOLO format text files
        output_csv = input_folder + "video" +str(count) + "_ball.csv"  # Replace with the desired output CSV file
        
        convert_yolo_to_csv(input_folder, output_csv, i)
        print(f"Conversion complete. CSV file saved to {output_csv}")
        shutil.copy(i, dir + "/videos/video"+str(count)+".mp4")
        count += 1
