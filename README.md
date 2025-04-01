# Docker Image for ROS2 Humble Development with Kinova and Additional Tools

## Overview

This Dockerfile sets up a development environment for [kinova_robust_control](https://github.com/roahmlab/kinova_robust_control/tree/humble), focusing on ROS2 Humble and support for Kinova's Kortex API.
The environment is built on the `ubuntu:22.04` base image.

### Key Features
- ROS2 Humble setup with essential tools.
- Integration with Kinova's API.
- Support for Python-based development and C++ with Conan.
- Installation of Pinocchio for robot kinematics and dynamics.
- Pre-installed utilities for debugging, testing, and development.

### Prerequisites

- **Docker Installed**: Ensure Docker is set up properly and running on your system.
- **Internet Access**: The Docker container uses host networking mode for communication.

---

## Build the Docker

We have provided a [Dockerfile](docker/Dockerfile) that will automatically install all the required packages. 
If you don't have Docker installed, you can find the installation instructions [here](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

#### 1. Clone the repository (together with kinova_robust_control):

```shell
git clone --recurse-submodules https://github.com/roahmlab/kinova_robust_control_docker.git
```

#### 2. Update kinova_robust_control (optional)

```shell
git submodule update --init --recursive
```

#### 2. Build docker based Visual Studio Code:
1. Open Visual Studio Code and Press `Ctrl+Shift+P`.
2. Search for `Dev Containers: Rebuild and Reopen Container`.
3. Select it to automatically build the environment from the [Dockerfile](docker/Dockerfile).

#### 3. Build kinova_robust_control

```shell
colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release
```

For more details, visit the [kinova_robust_control humble branch](https://github.com/roahmlab/kinova_robust_control/tree/humble).

---

## Detail for the dockerfile

#### Base Environment
- Uses Ubuntu 22.04.
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

#### Robot Kinematics and Dynamics with Pinocchio
- Installs the Pinocchio library for efficient robot dynamics computations.

#### Environment Variables
- Configures environment variables for ROS, Python, and installed libraries.

---

## Acknowlgement

The Docker file pulls code from the [KINOVA® KORTEX™ API Reference](https://github.com/Kinovarobotics/kortex) developed and maintained by [Kinova Robotics](https://www.kinovarobotics.com/). 
We gratefully acknowledge their work and contribution to the open-source robotics community.

---

## Credits

Sean Rice (Seanrice@umich.edu): Original creater of the docker file.

Zichang Zhou (zhouzichang1234@gmail.com): Clean up the docker file and the repository.

[Bohao Zhang](https://cfather.github.io/) (jimzhang@umich.edu): **Current maintainer**. Clean up the docker file and the repository.

---

## Rules
If you have any questions or suggestions, please raise them in [Issues](https://github.com/roahmlab/kinova_robust_control_docker/issues).
We will get back to you as soon as possible.










