FROM sdkmanager:latest

RUN sudo apt-get -qq update
RUN sudo apt-get -qq -y install \
    device-tree-compiler \
    parted \
    usbutils \
    libgtk-3.0 \
    libnss3 \
    libxss1 \
    libxtst6
RUN sudo apt-get clean
RUN sudo rm -rf /var/lib/apt-get/lists/*

COPY resources/docker-entrypoint.sh /docker-entrypoint.sh
RUN sudo chmod 755 /docker-entrypoint.sh

RUN sudo mkdir -p /var/lib/sdkmanager-docker/{nvidia,nvsdkm,nvidia_sdk}

RUN mkdir /home/nvidia/Downloads
RUN ln -s /var/lib/sdkmanager-docker/nvidia /home/nvidia/Downloads/nvidia
RUN mkdir /home/nvidia/nvidia
RUN ln -s /var/lib/sdkmanager-docker/nvidia_sdk /home/nvidia/nvidia/nvidia_sdk
RUN ln -s /var/lib/sdkmanager-docker/nvsdkm /home/nvidia/.nvsdkm

ENTRYPOINT ["/docker-entrypoint.sh"]
