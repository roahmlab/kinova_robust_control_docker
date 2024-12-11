# Docker Image for ROS2 Humble Development with Kinova and RAPTOR

## Overview

This Dockerfile sets up a development environment for [kinova_control](https://github.com/roahmlab/kinova_control/tree/ros2-humble-sysid-dev), focusing on ROS2 Humble and support for Kinova's Kortex API. 
It also includes essential tools and libraries for robotics, dynamics, and motion planning. 
The environment is built on the `nvidia/cuda:12.1.1-devel-ubuntu22.04` base image to leverage Nvidia GPUs and OpenGL for performance enhancements.

#### Key Features
- ROS2 Humble setup with essential tools.
- Integration with Kinova's API.
- Support for Python-based development and C++ with Conan.
- Installation of Pinocchio for robot dynamics and optional solver configurations (commented for customization).
- Pre-installed utilities for debugging, testing, and development.
- Work with [RAPTOR](https://github.com/roahmlab/RAPTOR).

#### Prerequisites

- **Docker Installed**: Ensure Docker is set up and running on your system.
- **Nvidia Drivers**: Required for GPU-accelerated functionality.
- **Internet Access**: The Docker container uses host networking mode for communication.

---

## Build the Docker

We strongly recommend using Docker. 
We have provided a Dockerfile that will automatically install all the required packages. 
If you don't have Docker installed, you can find the installation instructions [here](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

#### 1. Clone the repository (together with kinova_control):

```shell
git clone --recurse-submodules https://github.com/roahmlab/kinova_control_docker.git
```

#### 2. Update kinova_control (optional)

```shell
git submodule update --init --recursive
```

#### 2. Build docker based Visual Studio Code:
1. Open Visual Studio Code and Press `Ctrl+Shift+P`.
2. Search for `Dev Containers: Rebuild and Reopen Container`.
3. Select it to automatically build the environment from [docker/Dockerfile](docker/Dockerfile).

#### 3. Build kinova_control

```shell
colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release
```

For more details, visit the [kinova_control ROS2-Humble System Identification branch](https://github.com/roahmlab/kinova_control/tree/ros2-humble-sysid-dev).

---

## Detail for the dockerfile

#### Base Environment
- Uses Ubuntu 22.04 with Nvidia CUDA support.
- Sets non-interactive mode to streamline the installation process.

#### Locale and Dependencies
- Configures locales for `en_US.UTF-8`.
- Installs essential tools like `nano`, `git`, `python3`, `pip`, and compilers.

#### ROS2 Humble Installation
- Installs ROS2 Humble desktop packages.
- Adds ROS setup to the environment for easy access.

#### Kinova Kortex API
- Clones the Kortex repository.
- Installs the Kortex Python API for controlling Kinova robotic arms.

#### Python Development Tools
- Includes testing and linting tools such as `pytest`, `argcomplete`, and `flake8`.

#### C++ Dependencies
- Sets up Conan for dependency management.
- Configures default Conan profile for modern C++ standards.

#### Robot Dynamics with Pinocchio
- Installs the Pinocchio library for efficient robot dynamics computations.

#### Environment Variables
- Configures environment variables for ROS, Python, and installed libraries.

#### Optional Solvers (Commented)
- Placeholder commands for HSL, Ipopt, and OMPL installation, allowing flexibility for users needing specific solvers.

---
## Rules
If you have any questions or suggestions, please raise them in [Issues](https://github.com/roahmlab/kinova_control_docker/issues).
We will get back to you as soon as possible.










