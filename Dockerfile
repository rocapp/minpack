# Use an official Python runtime as a parent image
# FROM public.ecr.aws/lambda/python:3.9 as base
FROM ubuntu:latest

# Set the working directory in the container
WORKDIR /var/task

# Copy the local minpack directory contents into the container at /var/task/minpack
COPY . /var/task/minpack

# Install any needed packages specified in requirements.txt
RUN yum install -y \
    gcc \
    gcc-gfortran \
    ninja-build \
    libffi-devel \
    pkgconfig \
    && \
    yum clean all

# Build and install Minpack (plus python wrapper)
FROM base as build

# Set the working directory in the container
WORKDIR /var/task/minpack

#: check for pkg-config
RUN bash -c 'type pkg-config || echo "pkg-config not found"'

#: install python requirements
RUN pip3 install --upgrade pip && \
    pip install "https://github.com/fortran-lang/minpack/archive/refs/heads/main.zip#egg=minpack&subdirectory=python"

# Expose port 5000 to the outside world
EXPOSE 5000

# Add HEALTHCHECK instruction
HEALTHCHECK --interval=5m --timeout=3s \
    CMD curl -f http://localhost/ || exit 1

# Run lmdif function from minpack when the container launches
WORKDIR /var/task/minpack/python
ENTRYPOINT ["app.app"]
