FROM tensorflow/tensorflow:2.2.2-gpu-jupyter

# Update system
RUN apt update && apt upgrade -y

RUN apt install wget

RUN pip install --upgrade pip


RUN pip install --upgrade tensorflow
# RUN pip install --upgrade tensorflow-gpu

# Update CUDA
ENV DEBIAN_FRONTEND=noninteractive
# Add NVIDIA package repositories
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
RUN mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
RUN add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
RUN apt-get update

RUN wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb

RUN apt install -y ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
RUN apt-get update

# Install NVIDIA driver
RUN echo "82" | apt-get install -y --no-install-recommends nvidia-driver-450
# Reboot. Check that GPUs are visible using the command: nvidia-smi

RUN wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libnvinfer7_7.1.3-1+cuda11.0_amd64.deb
RUN apt install -y ./libnvinfer7_7.1.3-1+cuda11.0_amd64.deb
RUN apt-get update

ENV DEBIAN_FRONTEND=interactive

# Install development and runtime libraries (~4GB)
RUN apt-get install -y --allow-downgrades --no-install-recommends \
    cuda-11-0 \
    libcudnn8=8.0.4.30-1+cuda11.0  \
    libcudnn8-dev=8.0.4.30-1+cuda11.0


# Install TensorRT. Requires that libcudnn8 is installed above.
RUN apt-get install -y --no-install-recommends libnvinfer7=7.1.3-1+cuda11.0 \
    libnvinfer-dev=7.1.3-1+cuda11.0 \
    libnvinfer-plugin7=7.1.3-1+cuda11.0


# Install dependencies
RUN apt install -y libgl1-mesa-glx

RUN pip install keras \
                pillow \
                numpy \
                pandas \
                scikit-learn \
                matplotlib \
                opencv-python \
                tensorboard

# RUN apt autoclean
RUN apt autoremove -y

# Set up directories
RUN mkdir /tf/notebooks
RUN rm -d -R /tf/tensorflow-tutorials
RUN chown -R 1000:1000 /tf
# RUN ln -s /tf/notebooks /usr/src/notebooks

WORKDIR /usr/src
