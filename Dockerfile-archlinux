FROM base/archlinux
MAINTAINER Mathieu Tarral <mathieu.tarral@gmail.com>

# FRAMEWORKS            |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# ki18n                 |       qt5-script
# kguiaddons            |       qt5-quickcontrols
# kwindowsystem         |       qt5-x11extras
# kdocbook              |       docbook-xsl
# kwidgetsaddons        |       qt5-tools
# kiconthemes           |       qt5-svg
# kactivities           |       boost
# khtml                 |       giflib
# phonon-vlc            |       vlc
# phonon-gstreamer      |       pkg-config
# networkmanager-qt     |       libnm-glib
# plasma-nm             |       qca-qt5
# baloo                 |       lmdb
# kdewebkit             |       qt5-webkit
# kcodecs               |       gperf
# kservice              |       flex bison
# gpgme                 |       autoconf automake
# kirigami              |       qt5-quickcontrols2
# qca                   |       openssl-1.0
# purpose               |       intltool
#---------------------------------------------------------
# WORKSPACE             |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# user-manager          |       libpwquality
# kcm-touchpad          |       xf86-input-synaptics xorg-server-devel
# kde-gtk-config        |       gtkmm gtkmm3
# kwin                  |       libepoxy extra/xcb-util-cursor
# libnm-qt              |       libmm-glib
# oxygen-fonts          |       fontforge
# kdevplatform          |       qt5-quick1
# gwenview              |       exiv2
# libksane              |       sane
# kaccounts-integration |       libaccounts-qt signond
# plasma-pa             |       gconf libcanberra
#-----------------------|---------------------------------
# APPLICATIONS          |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# lokalize              |       hunspell
# kdevplatform          |       grantlee-qt5
# kdevelop              |       clang llvm
# kalgebra              |       glu
# marble                |       automoc4
# parley                |       qt5-multimedia
# artikulate            |       qt5-gstreamer
# step                  |       eigen
# khelpcenter           |       xapian-core
#-----------------------|---------------------------------
# PIM                   |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# prison                |       libdmtx qrencode
# kcalcore              |       libical
#-----------------------|---------------------------------

# General upgrade
#---------------------------
RUN pacman --noconfirm -Syu

# Install dependencies
#---------------------------
# build-essential
RUN pacman --noconfirm -Sy gcc git cmake make vim doxygen bzr
# kdesrc-build
RUN pacman --noconfirm -Sy perl perl-json perl-libwww perl-xml-parser dialog \
                            perl-io-socket-ssl qt5-base perl-yaml-libyaml
# Frameworks
RUN pacman --noconfirm -Sy \
                                qt5-script \
                                qt5-quickcontrols \
                                qt5-x11extras \
                                docbook-xsl \
                                qt5-tools \
                                qt5-svg boost \
                                giflib \
                                vlc \
                                pkg-config \
                                libnm-glib \
                                qca-qt5 \
                                qt5-webkit \
                                gperf \
                                flex bison \
                                autoconf automake \
                                qt5-quickcontrols2 \
                                openssl-1.0 \
                                intltool
# Workspace
RUN pacman --noconfirm -Sy \
                                libpwquality \
                                xf86-input-synaptics xorg-server-devel \
                                gtkmm gtkmm3 \
                                lmdb \
                                libepoxy extra/xcb-util-cursor \
                                libmm-glib \
                                fontforge \
                                exiv2 \
                                sane \
                                libaccounts-qt signond \
                                gconf libcanberra
# Applications
RUN pacman --noconfirm -Sy \
                                hunspell \
                                grantlee-qt5 \
                                clang llvm \
                                glu \
                                automoc4 \
                                qt5-multimedia \
                                qt5-gstreamer \
                                eigen \
                                xapian-core
# PIM
RUN pacman --noconfirm -Sy \
                                libdmtx qrencode \
                                libical
# Xorg & VNC
RUN pacman --noconfirm -Sy xorg-xsetroot xorg-xprop xorg-font-utils xorg-xmessage \
                            xorg-fonts-100dpi xorg-fonts-75dpi xorg-fonts-alias \
                            xorg-server-xvfb x11vnc

# setup kdedev account
RUN useradd -d /home/kdedev -m kdedev -G video && \
    pacman -S --noconfirm sudo && echo 'kdedev ALL=NOPASSWD: ALL' >> /etc/sudoers
# some symlinks in /root to handle sudo ./kdesrc-build
RUN ln -s /home/kdedev/.kdesrc-buildrc /root/.kdesrc-buildrc && \
    ln -s /home/kdedev/kdesrc-build /root/kdesrc-build && \
    mkdir -p /root/.vnc && ln -s /home/kdedev/.vnc/passwd /root/.vnc/passwd
USER kdedev
ENV HOME /home/kdedev
WORKDIR /home/kdedev/
# VNC setup
RUN mkdir -p ~/.vnc && x11vnc -storepasswd 1234 ~/.vnc/passwd
# kde anongit url alias
RUN git config --global url."git://anongit.kde.org/".insteadOf kde: && \
    git config --global url."ssh://git@git.kde.org/".pushInsteadOf kde: && \
    git clone git://anongit.kde.org/kdesrc-build.git 


VOLUME /work
VOLUME /qt

CMD ["bash"]
