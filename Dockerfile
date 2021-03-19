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
RUN mkdir /tf/notebooks
RUN rm -d -R /tf/tensorflow-tutorials
RUN chown -R 1000:1000 /tf
# RUN ln -s /tf/notebooks /usr/src/notebooks

WORKDIR /usr/src
