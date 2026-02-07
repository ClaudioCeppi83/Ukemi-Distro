# Ukemi Distro Builder - LFS Host Environment
FROM debian:stable-slim

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install LFS build prerequisites and base tools
RUN apt-get update && apt-get install -y \
    build-essential \
    bison \
    flex \
    gawk \
    texinfo \
    python3 \
    python3-yaml \
    wget \
    git \
    rsync \
    file \
    bc \
    libelf-dev \
    libssl-dev \
    zstd \
    curl \
    shellcheck \
    && rm -rf /var/lib/apt/lists/*

# Create LFS user and group
RUN groupadd lfs && \
    useradd -s /bin/bash -g lfs -m -k /dev/null lfs

# Set up the build environment shell
RUN echo "export LFS=/mnt/ukemi" >> /home/lfs/.bashrc && \
    echo "export LC_ALL=POSIX" >> /home/lfs/.bashrc && \
    echo "export LFS_TGT=$(uname -m)-lfs-linux-gnu" >> /home/lfs/.bashrc && \
    echo "export PATH=/usr/bin" >> /home/lfs/.bashrc && \
    echo "if [ ! -L /bin/sh ]; then ln -sf /bin/bash /bin/sh; fi" >> /home/lfs/.bashrc

# Set working directory
WORKDIR /mnt/ukemi

# We will mount build, output, and contexts as volumes
USER lfs

CMD ["/bin/bash"]
