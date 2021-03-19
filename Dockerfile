FROM tensorflow/tensorflow:2.2.2-gpu-jupyter

# Update system
RUN apt update && apt upgrade -y

RUN pip install --upgrade pip

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

# Set up directories
RUN ln -s /tf/notebooks /usr/src/notebooks


WORKDIR /usr/src
