FROM nvidia/cuda:11.3.0-cudnn8-devel-ubuntu18.04
# use an older system (18.04) to avoid opencv incompatibility (issue#3524)

ENV DEBIAN_FRONTEND noninteractive
RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-get update && apt-get install -y \
	python3-opencv ca-certificates python3-dev git wget sudo ninja-build
RUN ln -sv /usr/bin/python3 /usr/bin/python

# create a non-root user
ARG USER_ID=1000
RUN useradd -m --no-log-init --system  --uid ${USER_ID} appuser -g sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER appuser
WORKDIR /home/appuser

ENV PATH="/home/appuser/.local/bin:${PATH}"
RUN wget https://bootstrap.pypa.io/pip/3.6/get-pip.py && \
	python3 get-pip.py --user && \
	rm get-pip.py

# install dependencies
# See https://pytorch.org/ for other options if you use a different version of CUDA


RUN pip install --user tensorboard cmake   # cmake from apt-get is too old
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113
# RUN pip install --user nnunet
RUN git clone https://github.com/meglaficus/nnUNet.git && cd nnUNet && pip install -e .

ENV FORCE_CUDA="1"
# This will by default build detectron2 for all common cuda architectures and take a lot more time,
# because inside `docker build`, there is no way to tell which architecture will be used.
ARG TORCH_CUDA_ARCH_LIST="Kepler;Kepler+Tesla;Maxwell;Maxwell+Tegra;Pascal;Volta;Turing"
ENV TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST}"

# change default shell to bash
SHELL ["/bin/bash", "-ec"]
RUN sudo apt install -y tmux

RUN cd /home/appuser
RUN sudo mkdir nnUNet_files
RUN sudo mkdir outputs

ENV nnUNet_raw_data_base="/home/appuser/nnUNet_files/nnUNet_raw_data_base"
ENV nnUNet_preprocessed="/home/appuser/nnUNet_files/nnUNet_preprocessed"
ENV RESULTS_FOLDER="/home/appuser/nnUNet_files/nnUNet_trained_models"

# FROM bitnami/pytorch

# create a non-root user
# ARG USER_ID=1000
# RUN useradd -m --no-log-init --system  --uid ${USER_ID} appuser -g sudo
# RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# USER appuser
# WORKDIR /home/appuser

# RUN sudo mkdir /.local
# RUN chmod -R 777 /.local
# RUN pip install --user nnunet

# RUN sudo apt install -y tmux
# SHELL ["/bin/bash", "-ec"]