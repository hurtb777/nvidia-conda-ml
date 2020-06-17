#!/usr/bin/env bash

# Use a baseline to build from, in this case a linux OS with CUDA 9.0 and cuDNN 7 from the nvidia-repo
FROM nvidia/cuda:10.1-cudnn7-runtime

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
SHELL ["/bin/bash", "--login", "-c"]

# Run the following commands as you would from Linux; install major programs/dependencies
RUN apt-get update && \
  apt-get install -y libgtk2.0-0 wget bzip2 curl git ca-certificates && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install Miniconda - a scientific python distribution
RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -p /opt/miniconda -b && \
    rm -rf ~/miniconda.sh && \
    /opt/miniconda/bin/conda clean -tipsy && \
    ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    source ~/.bashrc
