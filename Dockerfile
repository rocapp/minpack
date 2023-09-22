# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory in the container
WORKDIR /app

# Copy the local minpack directory contents into the container at /app/minpack
COPY . /app/minpack

# Install any needed packages specified in requirements.txt
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    gfortran \
    meson \
    ninja-build \
    libffi-dev && \
    python3-pip && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install -r /app/minpack/python/requirements.txt

# Build and install Minpack (plus python wrapper)
WORKDIR /app/minpack
RUN bash ./install_minpack.sh

# Create a non-root user
RUN useradd -m myuser
USER myuser

# Expose port 5000 to the outside world
EXPOSE 5000

# Add HEALTHCHECK instruction
HEALTHCHECK --interval=5m --timeout=3s \
    CMD curl -f http://localhost/ || exit 1

# Run lmdif function from minpack when the container launches
WORKDIR /app/minpack/python
ENTRYPOINT ["quart"]
