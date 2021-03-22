FROM tensorflow/tensorflow:2.4.1-gpu-jupyter

# Update system
RUN apt update && apt upgrade -y

RUN apt autoremove -y

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
                tensorboard \
                tqdm

# RUN apt autoclean

# Set up directories
RUN mkdir /tf/notebooks
RUN rm -d -R /tf/tensorflow-tutorials
RUN chown -R 1000:1000 /tf
# RUN ln -s /tf/notebooks /usr/src/notebooks

WORKDIR /usr/src
