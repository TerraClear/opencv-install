# opencv-install
Installing OpenCV from source and install pre-reqs..

#1. Install CUDA 10.1
--------------------
- Download and install CUDA 10.1 from: https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=debnetwork

#2. Fix NVCC Cuda Compiler path.
-------------------------------
-  Edit '/etc/environment' and add an entry for '/usr/local/cuda/bin'
-  Logout or Reboot
-  In a terminal, run 'echo $PATH' to confirm the path has been added.

#3. Install CUDNN
----------------
- Download and install from: https://developer.nvidia.com/rdp/cudnn-download
- Install CUDNN Runtime from DEB
- install CUDNN Developer Library from DEB
- Install CUDNN Docs from DEB

#4. Download NVIDIA VIDEO CODEC SDK
--------------------------
- Download from https://developer.nvidia.com/nvidia-video-codec-sdk#Download
- Copy all files from 'include' folder to to '/usr/local/cuda/include'
```
sudo cp include/*.h /usr/local/cuda/include
```
** For OpenCV 3.4.6, rename or copy nvcuvid.h to dynlink_nvcuvid.h
```
sudo cp include/nvcuvid.h /usr/local/cuda/include/dynlink_nvcuvid.h
```

#5. Build from source and install OpenCV
---------------------------------------
- Edit script of your choice and change cvVersion to match install.
- Run the script to install all pre-reqs and build and install OpenCV

** NOTE for OpenCV4 you would need to create symlink to OpenCV2 path
- sudo ln -s /usr/local/include/opencv4/opencv2 /usr/local/include/opencv2
- Also, any projects linked with opencv pkconfig library would need to use opencv4 instead

