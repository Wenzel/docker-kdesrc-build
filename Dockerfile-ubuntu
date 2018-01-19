FROM ubuntu:17.10
MAINTAINER Mathieu Tarral <mathieu.tarral@gmail.com>

# FRAMEWORKS            |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# kcodecs               |       gperf
# kservice              |       flex bison
# ki18n                 |       qtscript5-dev
# kwindowsystem         |       libqt5x11extras5-dev
# kwidgetsaddons        |       qttools5-dev
# kiconthemes           |       libqt5svg5-dev
# kwallet               |       libgcrypt20-dev
# kdeclarative          |       qtdeclarative5-dev libepoxy-dev
# kactivities           |       libboost-all-dev
# kdewebkit             |       libqt5webkit5-dev
# kdelib4support        |       libsm-dev
# khtml                 |       libgif-dev libjpeg-dev libpng-dev
# frameworkintegration  |       libxcursor-dev
# ktexteditor           |       libqt5xmlpatterns5-dev
# polkit-qt-1           |       libpolkit-agent-1-dev
# phonon-vlc            |       libvlc-dev libvlccore-dev
# phonon-gstreamer      |       libgstreamer-plugins-base1.0-dev
# akonadi               |       xsltproc
# networkmanager-qt     |       libnm-glib-dev modemmanager-dev
#-----------------------|---------------------------------

# Install dependencies
#---------------------------
# set noninteractive frontend only during build
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-key adv --recv-keys && \
    apt-get install -y git bzr vim g++ cmake tar doxygen && \
    apt-get install -y libwww-perl libxml-parser-perl libjson-perl libyaml-libyaml-perl dialog gettext libxrender-dev pkg-config libxcb-keysyms1-dev docbook-xsl libxslt1-dev libxml2-utils libudev-dev libqt4-dev && \
    apt-get install -y \
                        gperf \
                        flex bison \
                        qtscript5-dev \
                        libqt5x11extras5-dev \
                        qttools5-dev \
                        libqt5svg5-dev \
                        libgcrypt20-dev \
                        qtdeclarative5-dev libepoxy-dev \
                        libboost-all-dev \
                        libqt5webkit5-dev \
                        libsm-dev \
                        libgif-dev libjpeg-dev libpng-dev \
                        libxcursor-dev \
                        libqt5xmlpatterns5-dev \
                        libpolkit-agent-1-dev \
                        libvlc-dev libvlccore-dev \
                        libgstreamer-plugins-base1.0-dev \
                        xsltproc \
                        libnm-glib-dev modemmanager-dev && \
    useradd -d /home/kdedev -m kdedev && \
    mkdir /work /qt && \
    chown kdedev /work /qt

# some symlinks in /root to handle sudo ./kdesrc-build
RUN ln -s /home/kdedev/.kdesrc-buildrc /root/.kdesrc-buildrc && \
    ln -s /home/kdedev/kdesrc-build /root/kdesrc-build
# setup kdedev account
RUN apt-get install -y sudo && echo 'kdedev ALL=NOPASSWD: ALL' >> /etc/sudoers
USER kdedev
ENV HOME /home/kdedev
WORKDIR /home/kdedev/
# kde anongit url alias
RUN git config --global url."git://anongit.kde.org/".insteadOf kde: && \
    git config --global url."ssh://git@git.kde.org/".pushInsteadOf kde: && \
    git clone git://anongit.kde.org/kdesrc-build.git 

VOLUME /work
VOLUME /qt

CMD ["bash"]
