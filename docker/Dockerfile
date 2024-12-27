# Use NVIDIA's CUDA base image with Ubuntu 22.04
FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

# Set non-interactive mode for apt-get to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Create necessary directories for workspace
RUN mkdir -p /home/roahmlab/path_ws/src
RUN mkdir -p /home/roahmlab/src

# Install basic tools and dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \    
    nano \                         
    python3-yaml \                  
    git \                        
    python3.10 \                       
    python3-pip \
    python3-pytest-cov \
    curl \                        
    wget \                        
    sudo \                       
    locales \                   
    lsb-release \               
    gnupg2 \                       
    && rm -rf /var/lib/apt/lists/*  

# Configure locales
RUN locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8

# Add ROS2 repository and import its keys
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" \
    | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install ROS2 Humble and essential ROS tools
RUN apt-get update && apt-get install -y \
    ros-humble-desktop \    
    ros-dev-tools \             
    python3-colcon-common-extensions \    
    python3-argcomplete \ 
    libbullet-dev \                    
    python3-pytest-cov \             
    libasio-dev \  
    libtinyxml2-dev\
    libcunit1-dev \ 
    libspdlog-dev \               
    nlohmann-json3-dev \ 
    ros-humble-pybind11-vendor\ 
    gcc\
    lcov\ 
    valgrind\
    gdb\            
    && rm -rf /var/lib/apt/lists/*

# Automatically source ROS setup script in each new shell
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc

# Set the working directory for cloning repositories
WORKDIR /home/roahmlab/src

# Clone Kinova's Kortex API and install it
RUN git clone https://github.com/Kinovarobotics/kortex.git
RUN wget "https://artifactory.kinovaapps.com/ui/api/v1/download?repoKey=generic-public&path=kortex%252FAPI%252F2.6.0%252Fkortex_api-2.6.0.post3-py3-none-any.whl&isNativeBrowsing=false" -O /tmp/kortex_api-2.6.0.post3-py3-none-any.whl && python3 -m pip install /tmp/kortex_api-2.6.0.post3-py3-none-any.whl

# Set up Conan, a package manager for C++ dependencies
RUN python3 -m pip install conan==1.59
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
    conan config set general.revisions_enabled=1 && \
    conan profile new default --detect && \
    conan profile update settings.compiler.libcxx=libstdc++11 default"

# Install Python tools for testing and linting
RUN python3 -m pip install -U \
    numpy==1.25.2 \
    argcomplete \
    flake8-blind-except \
    flake8-builtins \
    flake8-class-newline \
    flake8-comprehensions \
    flake8-deprecated \
    flake8-docstrings \
    flake8-import-order \
    flake8-quotes \
    pytest-repeat \
    pytest-rerunfailures \
    pytest \
    pybind11 \
    nanobind \
    pygccxml \
    pyplusplus \
    scipy \
    matplotlib \
    pyyaml \
    rosbags
    
# apt install -y \
#    python3-flake8-blind-except \
#    python3-flake8-builtins \
#    python3-flake8-class-newline \
#    python3-flake8-comprehensions \
#    python3-flake8-deprecated \
#    python3-flake8-import-order \
#    python3-flake8-quotes \
#    python3-pytest-repeat \
#    python3-pytest-rerunfailures

RUN echo "export CONAN_REVISIONS_ENABLED=1" >> /root/.bashrc && echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc

RUN apt-get update && apt-get install -y \
    libgflags-dev \
    libgoogle-glog-dev \
    libusb-1.0-0-dev \
    libboost-all-dev \
    libopenblas-dev \
    libeigen3-dev \
    libgsl-dev \
    liblapack-dev \
    libmetis-dev \
    libyaml-cpp-dev \
    uuid-dev \
    pkg-config \
    ninja-build \
    doxygen \
    unzip \
    clang \
    gcc-multilib \
    g++-multilib \
    python3 \
    nasm \
    libgl1-mesa-dev \
    libsoundio-dev \
    libvulkan-dev \
    libx11-dev \
    libxcursor-dev \
    libxinerama-dev \
    libxrandr-dev \
    libssl-dev \
    libudev-dev \
    mesa-common-dev \
    python3-dev \
    python3-venv \
    python3-pip \
    python3-opencv\
    && rm -rf /var/lib/apt/lists/*

# Below is for RAPTOR
    # Copy the HSL source code folder into the Docker image
COPY docker/HSL.zip /home/roahmlab/src

# Mount and install Pinocchio (robot dynamics library)
RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=bind,source=docker/install-pinocchio.sh,target=/tmp/install-pinocchio.sh \
    bash /tmp/install-pinocchio.sh

# Mount and install the HSL solver
RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=bind,source=docker/install-hsl.sh,target=/tmp/install-hsl.sh \
    bash /tmp/install-hsl.sh

# Mount and install the Ipopt solver (optimization library)
RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=bind,source=docker/install-ipopt.sh,target=/tmp/install-ipopt.sh \
    bash /tmp/install-ipopt.sh

# Mount and install the OMPL library (motion planning)
RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=bind,source=docker/install-ompl.sh,target=/tmp/install-ompl.sh \
    bash /tmp/install-ompl.sh

# Set environment variables for installed libraries
# Set unified environment variables
ENV ROS_DISTRO=humble \
    ROS_ROOT=/opt/ros/$ROS_DISTRO \
    ROS_PYTHON_VERSION=3 \
    PATH=/opt/openrobots/bin:/usr/local/bin:/usr/bin:/usr/local/cuda/bin:$ROS_ROOT/bin:$PATH \
    LD_LIBRARY_PATH=/opt/openrobots/lib:/usr/lib:/usr/lib/x86_64-linux-gnu:/usr/local/lib:/usr/local/share:/usr/local/cuda/lib64:$ROS_ROOT/lib:$LD_LIBRARY_PATH \
    PYTHONPATH=/opt/openrobots/lib/python3.10/site-packages:$ROS_ROOT/lib/python3.10/site-packages:$PYTHONPATH \
    CMAKE_PREFIX_PATH=/opt/ros/humble:/usr:/opt/openrobots:/usr/local:/usr/lib/x86_64-linux-gnu/urdfdom/cmake:$ROS_ROOT:$CMAKE_PREFIX_PATH \
    PKG_CONFIG_PATH=/opt/openrobots/lib/pkgconfig:$PKG_CONFIG_PATH

# Ensure ROS setup is sourced in every shell
# RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc
RUN apt-get update && apt-get install -y iputils-ping

# Set the default command to open a Bash shell
CMD ["/bin/bash"]

USER $USERNAME