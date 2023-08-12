FROM tensorflow/tensorflow:2.13.0-gpu-jupyter
RUN yes| unminimize
# Set ENV variables
ENV LANG C.UTF-8
ENV SHELL=/bin/bash
ENV DEBIAN_FRONTEND=noninteractive
ENV APT_INSTALL="apt-get install -y --no-install-recommends"
ENV PIP_INSTALL="python -m pip --no-cache-dir install --upgrade"
ENV GIT_CLONE="git clone --depth 10"

# installing base operation packages

RUN apt-get update && \
    $APT_INSTALL \
    apt-utils \
    gcc \
    make \
    pkg-config \
    apt-transport-https \
    build-essential \
    ca-certificates \
    wget \
    rsync \
    git \
    vim \
    mlocate \
    libssl-dev \
    curl \
    openssh-client \
    unzip \
    unrar \
    zip \
    csvkit \
    emacs \
    joe \
    jq \
    dialog \
    man-db \
    manpages \
    manpages-dev \
    manpages-posix \
    manpages-posix-dev \
    nano \
    iputils-ping \
    sudo \
    ffmpeg \
    libsm6 \
    libxext6 \
    libboost-all-dev \
    cifs-utils \
    software-properties-common

RUN add-apt-repository ppa:deadsnakes/ppa -y && \
# Installing python3.11
    $APT_INSTALL \
    python3.10 \
    python3.10-dev \
    python3.10-venv \
    python3-distutils-extra

# Add symlink so python and python3 commands use same python3.10 executable
RUN ln -s /usr/bin/python3.10 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.10 /usr/local/bin/python
# Installing pip
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
ENV PATH=$PATH:/root/.local/bin

# Update setuptools
RUN pip install --upgrade setuptools

# Installing pip packages


RUN $PIP_INSTALL git+https://github.com/guorbit/utilities.git
RUN pip install \
    cython\
    numpy==1.23.4 \
    pandas==1.5.0 \
    matplotlib==3.6.1 \
    ipython==8.5.0 \
    ipykernel==6.16.0 \
    ipywidgets==8.0.2 \
    tqdm==4.64.1 \
    pillow==9.2.0 \
    seaborn==0.12.0 \
    tabulate==0.9.0 \
    gradient==2.0.6 \
    jsonify==0.5 \
    wandb==0.13.4 \
    jupyterlab-snippets==0.4.1 

RUN $APT_INSTALL \
    default-jre \
    default-jdk

RUN $GIT_CLONE https://github.com/Kitware/CMake ~/cmake && \
    cd ~/cmake && \
    ./bootstrap && \
    make -j"$(nproc)" install

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash  && \
    $APT_INSTALL nodejs  && \
    $PIP_INSTALL jupyter_contrib_nbextensions jupyterlab-git && \
    jupyter contrib nbextension install --user


EXPOSE 8888 6006
CMD jupyter lab --allow-root --ip=0.0.0.0 --no-browser --ServerApp.trust_xheaders=True --ServerApp.disable_check_xsrf=False --ServerApp.allow_remote_access=True --ServerApp.allow_origin='*' --ServerApp.allow_credentials=True

# Install dependencies
