FROM sdkmanager:latest

RUN sudo apt-get -qq update
RUN sudo apt-get -qq -y install \
    parted \
    usbutils \
    libgtk-3.0 \
    libnss3 \
    libxss1 \
    libxtst6
RUN sudo apt-get clean
RUN sudo rm -rf /var/lib/apt-get/lists/*

ENTRYPOINT []
CMD ["/opt/nvidia/sdkmanager/sdkmanager-gui"]
