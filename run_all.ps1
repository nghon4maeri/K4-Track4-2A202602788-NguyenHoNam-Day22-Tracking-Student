$env:LAB_DATA = "data_lab21"
$env:PYTHONUTF8 = "1"

Write-Host "Running video_1..."
C:\Users\nghoo\AppData\Local\anaconda3\envs\cv_robotics_lab21\python.exe scripts/run_tracking.py --source "data_lab21/video_1/img1" --seq-name video_1 --tracker bytetrack --conf 0.3 --iou 0.5 --out runs/nop_bai --save-video

Write-Host "Running video_2..."
C:\Users\nghoo\AppData\Local\anaconda3\envs\cv_robotics_lab21\python.exe scripts/run_tracking.py --source "data_lab21/video_2/img1" --seq-name video_2 --tracker ocsort --conf 0.2 --iou 0.4 --out runs/nop_bai --save-video

Write-Host "Running video_3..."
C:\Users\nghoo\AppData\Local\anaconda3\envs\cv_robotics_lab21\python.exe scripts/run_tracking.py --source "data_lab21/video_3/img1" --seq-name video_3 --tracker botsort --conf 0.25 --iou 0.5 --out runs/nop_bai --save-video

Write-Host "Running video_4..."
C:\Users\nghoo\AppData\Local\anaconda3\envs\cv_robotics_lab21\python.exe scripts/run_tracking.py --source "data_lab21/video_4/img1" --seq-name video_4 --tracker deepocsort --conf 0.3 --iou 0.5 --out runs/nop_bai --save-video

Write-Host "Running video_5..."
C:\Users\nghoo\AppData\Local\anaconda3\envs\cv_robotics_lab21\python.exe scripts/run_tracking.py --source "data_lab21/video_5/img1" --seq-name video_5 --tracker botsort --conf 0.3 --iou 0.5 --out runs/nop_bai --save-video

Write-Host "Evaluating video_1..."
C:\Users\nghoo\AppData\Local\anaconda3\envs\cv_robotics_lab21\python.exe scripts/evaluate_practice.py --trackeval-root TrackEval --lab-data-root "data_lab21" --submission runs/nop_bai/video_1.txt --run-name nop_bai_video1 > runs/eval_result.txt
Get-Content runs/eval_result.txt
