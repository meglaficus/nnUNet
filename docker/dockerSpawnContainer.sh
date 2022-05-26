
docker run --gpus all -it -v C:\Users\jakob\Documents\GitHub\nnUnet\nnUNet_files:/nnUNet_files --shm-size=24gb nnunet:0.2

#used to spawn original test container
#docker run --gpus all -it --shm-size=24gb nnunet:0.1


# -v /home/coline/ObjectDetector:/ObjectDetector