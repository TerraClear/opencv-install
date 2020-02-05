#!/bin/bash


#install opencv
cvVersion="4.2.0"

# Save current working directory
cwd=$(pwd)

# update packages
sudo apt -y update
sudo apt -y upgrade

#remove old x264 libs if needed
sudo apt -y remove x264 libx264-dev

# Install dependencies
sudo apt -y install build-essential cmake checkinstall cmake pkg-config yasm
sudo apt -y install git gfortran

#install image formats support
sudo apt -y install -y libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libpng-dev libdc1394-22-dev

#install video codecs
sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
sudo apt -y install x264 libv4l-dev v4l-utils libxine2-dev qv4l2 v4l2ucp
cd /usr/include/linux
sudo ln -s -f ../libv4l1-videodev.h videodev.h
cd $cwd

sudo apt -y install libgtk2.0-dev qt5-default
sudo apt -y install libatlas-base-dev
sudo apt -y install libfaac-dev libmp3lame-dev libtheora-dev
sudo apt -y install libvorbis-dev libxvidcore-dev
sudo apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt -y install libavresample-dev

# Optional dependencies
sudo apt -y install libprotobuf-dev protobuf-compiler
sudo apt -y install libgoogle-glog-dev libgflags-dev
sudo apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

#install g-streamer support
sudo apt -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

#install Python bits
sudo apt -y install -y python2.7-dev python3.6-dev python-dev python-numpy python3-numpy

#clone OpenCV
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout $cvVersion
cd ..

git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout $cvVersion
cd ..

# compile and install
cd opencv
mkdir build
cd build

# -D BUILD_opencv_cudacodec=ON \
#-D WITH_V4L=ON 
#-D WITH_LIBV4L=ON
# -DWITH_FFMPEG=1
#

cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D BUILD_opencv_python3=ON \
      -D PYTHON_EXECUTABLE=/usr/bin/python3.6 \
      -D PYTHON_INCLUDE_DIR=/usr/include/python3.6 \
      -D PYTHON_INCLUDE_DIR2=/usr/include/x86_64-linux-gnu/python3.6m \
      -D PYTHON_LIBRARY=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/libpython3.6.so \
      -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/lib/python3/dist-packages/numpy/core/include/numpy \
      -D INSTALL_C_EXAMPLES=OFF \
      -D INSTALL_PYTHON_EXAMPLES=OFF \
      -D BUILD_JPEG=ON \
      -D WITH_JPEG=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_LIBV4L=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D WITH_GSTREAMER=ON \
      -D WITH_CUDA=ON \
      -D WITH_NVCUVID=ON \
      -D CUDA_FAST_MATH=ON\
      -D WITH_CUBLAS=ON \
      -D BUILD_opencv_cudacodec=ON \
      -D WITH_FFMPEG=ON \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      -D OPENCV_GENERATE_PKGCONFIG=YES \
      -D BUILD_EXAMPLES=OFF ..
      
# make with 12 cores..
make -j12
sudo make install
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig

