# Use an official Python runtime as a parent image
FROM ubuntu:latest

# Install any needed packages specified in requirements.txt
RUN apt-get update && apt-get upgrade -y && \
    apt install -y \
    gcc \
    gfortran \
    ninja-build \
    libffi-dev \
    pkg-config \
    python3-pip \
    meson \
    mlocate

#: install python requirements
RUN pip3 install --upgrade pip && \
    pip install "https://github.com/fortran-lang/minpack/archive/refs/heads/main.zip#egg=minpack&subdirectory=python" \
    setuptools \
    wheel

# Build and install Minpack (plus python wrapper)

# Copy the local minpack directory contents into the container
COPY . /app
WORKDIR /app

RUN ./scripts/install_minpack.sh
