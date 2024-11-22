# Docker Image for ROS2 Foxy Development with Kinova and Additional Tools

## Overview

This Dockerfile sets up a development environment for robotics projects, focusing on ROS2 Foxy and support for Kinova's Kortex API. It also includes essential tools and libraries for robotics, dynamics, and motion planning. The environment is built on the `nvidia/opengl:base-ubuntu20.04` base image to leverage Nvidia GPUs and OpenGL for performance enhancements.

---

### Key Features
- ROS2 Foxy setup with essential tools.
- Integration with Kinova's API.
- Support for Python-based development and C++ with Conan.
- Installation of Pinocchio for robot dynamics and optional solver configurations (commented for customization).
- Pre-installed utilities for debugging, testing, and development.

---

## Prerequisites

- **Docker Installed**: Ensure Docker is set up and running on your system.
- **Nvidia Drivers**: Required for GPU-accelerated functionality.
- **Internet Access**: The Docker container uses host networking mode for communication.

---


## Build the Docker

We strongly recommend using Docker. We have provided a Dockerfile that will automatically install all the required packages. If you don't have Docker installed, you can find the installation instructions [here](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

### Docker
#### 1. Clone the repository:

```shell
git clone https://github.com/Zichangzhou1234/kinova_control_docker.git
```

#### 2. Build docker based Visual Studio Code:
1. Open Visual Studio Code and Press `Ctrl+Shift+P`.
2. Search for `Dev Containers: Rebuild and Reopen Container`.
3. Select it to automatically build the environment from [docker/Dockerfile](docker/Dockerfile).

#### 3. Add the Kinova Control:
Navigate to the src/ directory and add the Kinova Control repository:
```shell
cd src/
git clone https://github.com/roahmlab/kinova_control.git
```
**Note**: The Kinova Control repository linked above is **not the latest version**. The correct version can be obtained from **winboz**. For more details, visit the [Kinova Control ROS2 branch](https://github.com/roahmlab/kinova_control/tree/ros2).



<!-- ### HSL
You should complete HSL steps BEFORE you build the docker image otherwise you will have error.

We have selected [HSL](https://www.hsl.rl.ac.uk/) to solve large linear systems in the nonlinear optimization problem. 
Please follow the instructions below to complete the installation.
Note that this is ONLY for SINGLE PRECISION version!!!
1. Go to [HSL MA57](https://www.hsl.rl.ac.uk/catalogue/hsl_ma57.html) official website. Click `Code Download` and follow its instructions. After submitting the request, wait a few minute for email reply.
2. Download the code in the link that HSL provides you. The name of the zip file and the folder inside it is going to be `hsl_ma57` + its version number. 
3. Extract the code and rename the folder as `hsl_ma57`. Compress the folder again and rename the zip file as `hsl_ma57.zip` (just make sure both of them are named as `hsl_ma57` by removing the version number).
4. Note: This zip file will later be 'unziped' and built inside the docker container. -->

---

## Detail for the dockerfile

### Base Environment
- Uses Ubuntu 20.04 with Nvidia OpenGL support.
- Sets non-interactive mode to streamline the installation process.

### Locale and Dependencies
- Configures locales for `en_US.UTF-8`.
- Installs essential tools like `nano`, `git`, `python3`, `pip`, and compilers.

### ROS2 Foxy Installation
- Installs ROS2 Foxy desktop packages.
- Adds ROS setup to the environment for easy access.

### Kinova Kortex API
- Clones the Kortex repository.
- Installs the Kortex Python API for controlling Kinova robotic arms.

### Python Development Tools
- Includes testing and linting tools such as `pytest`, `argcomplete`, and `flake8`.

### C++ Dependencies
- Sets up Conan for dependency management.
- Configures default Conan profile for modern C++ standards.

### Robot Dynamics with Pinocchio
- Installs the Pinocchio library for efficient robot dynamics computations.

### Environment Variables
- Configures environment variables for ROS, Python, and installed libraries.

### Optional Solvers (Commented)
- Placeholder commands for HSL, Ipopt, and OMPL installation, allowing flexibility for users needing specific solvers.












