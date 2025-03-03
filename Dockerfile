# # Use an official PyTorch base image with CUDA support
# FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04

# Use your existing image as the base
FROM runpod/base:0.6.3-cuda11.8.0

# Set the working directory
WORKDIR /home/CLoSD

# Install git
RUN apt-get update && apt-get install -y git
RUN apt install screen -y
RUN apt install htop

# Install Miniconda
ENV MINICONDA_VERSION=py38_4.9.2
ENV CONDA_DIR=/opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p ${CONDA_DIR} && \
    rm /tmp/miniconda.sh && \
    ${CONDA_DIR}/bin/conda clean -tipsy && \
    ln -s ${CONDA_DIR}/bin/conda /usr/bin/conda
     
# Add Conda to PATH
ENV PATH=${CONDA_DIR}/bin:${PATH}

# Update and install JupyterLab
RUN pip install --upgrade pip && \
    pip install jupyterlab

EXPOSE 8888


# Copy the repository contents
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip
RUN pip install -r requirement.txt
RUN pip install hf_transfer

