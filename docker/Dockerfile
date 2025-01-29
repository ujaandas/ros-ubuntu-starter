# Source base image
ARG ROS_DISTRO=jazzy
FROM ros:${ROS_DISTRO}-ros-base

# Set env vars
ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_WS=/root/fyp/ros2_ws
ENV SHARED_ROS=/root/fyp/shared/

# Use bash instead of sh
SHELL ["/bin/bash", "-c"]

# Update system
RUN apt-get update -q && \
    apt-get upgrade -yq

# Install basic tools
RUN apt-get install -yq --no-install-recommends apt-utils wget curl git build-essential \
    vim sudo lsb-release locales bash-completion tzdata gosu gedit htop nano libserial-dev

# Install additional tools for ROS
RUN apt-get install -yq gnupg2 iputils-ping usbutils \
    python3-argcomplete python3-colcon-common-extensions python3-networkx python3-pip python3-rosdep python3-vcstool

# Install ROS2 packages
RUN apt-get install -yq \
    ros-${ROS_DISTRO}-joint-state-publisher-gui \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-demo-nodes-cpp \
    ros-${ROS_DISTRO}-demo-nodes-py \
    ros-${ROS_DISTRO}-rviz2 \
    ros-${ROS_DISTRO}-rqt-reconfigure

# Install Mesa for 3D
RUN apt-get install -y software-properties-common && \
    DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:kisak/kisak-mesa

# Create necessary directories and copy files
RUN mkdir -p /etc/udev/rules.d $ROS_WS/src/
COPY . $ROS_WS/src/
COPY docker/workspace.sh /root/
COPY docker/entrypoint.sh /root/
RUN chmod +x /root/workspace.sh /root/entrypoint.sh

# Set up ROS2 environment
RUN rosdep update && \
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc && \
    echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> /root/.bashrc && \
    echo "source $ROS_WS/install/setup.bash" >> /root/.bashrc

# Install workspace dependencies and build
WORKDIR /root
RUN ./workspace.sh

# Set container entrypoint
ENTRYPOINT ["/root/entrypoint.sh"]

# Run container indef., for exec-ability
CMD ["/bin/bash", "-c", "tail -f /dev/null"]