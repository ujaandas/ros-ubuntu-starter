# Source base image
ARG ROS_DISTRO=jazzy
FROM ros:${ROS_DISTRO}-ros-base

# Set env vars
ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV DEBIAN_FRONTEND=noninteractive

# Use bash instead of sh
SHELL ["/bin/bash", "-c"]

# Update system, install all reqd. tools
RUN apt-get update -q && \
    apt-get upgrade -yq && \
    apt-get install -yq --no-install-recommends apt-utils wget curl git build-essential \
    vim sudo lsb-release locales bash-completion tzdata gosu gedit htop nano libserial-dev

# Install addl. tools reqd. for ROS
RUN apt-get update -q && \
    apt-get install -y gnupg2 iputils-ping usbutils \
    python3-argcomplete python3-colcon-common-extensions python3-networkx python3-pip python3-rosdep python3-vcstool

# Set up ROS2 env
RUN rosdep update && \
    grep -F "source /opt/ros/${ROS_DISTRO}/setup.bash" /root/.bashrc || echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc && \
    grep -F "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" /root/.bashrc || echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> /root/.bashrc

# Install ROS2 pkgs
RUN apt-get update && \
    apt-get install -y \
    ros-${ROS_DISTRO}-joint-state-publisher-gui \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-demo-nodes-cpp \
    ros-${ROS_DISTRO}-demo-nodes-py \
    ros-${ROS_DISTRO}-rviz2 \
    ros-${ROS_DISTRO}-rqt-reconfigure

# Install Mesa for 3D
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:kisak/kisak-mesa

# Create necessary directories
RUN mkdir -p /etc/udev/rules.d && \
    mkdir -p /root/fyp/ros2_ws/src/gyattbot

# Copy all
COPY . /root/fyp/ros2_ws/src/gyattbot

# Copy all config (using docker prefix for docker's context)
COPY docker/workspace.sh /root/
COPY docker/entrypoint.sh /root/

# Make em all execable
RUN chmod +x /root/workspace.sh /root/entrypoint.sh

# Install ws deps and build
WORKDIR /root
RUN ./workspace.sh

# Source ws in each shell
RUN echo "source /root/ros2_ws/install/setup.bash" >> /root/.bashrc

# Set container entrypoint
ENTRYPOINT ["/root/entrypoint.sh"]

# Run container indef., for exec-ability
CMD ["/bin/bash", "-c", "tail -f /dev/null"]