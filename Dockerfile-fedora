FROM fedora:27
MAINTAINER Mathieu Tarral <mathieu.tarral@gmail.com>

# FRAMEWORKS            |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# ki18n                 |       qt5-qtscript-devel gettext-devel
# kcodecs               |       gperf
# kservice              |       flex bison
# kwindowsystem         |       qt5-qtx11extras-devel libXrender-devel xcb-util-keysyms-devel
# karchive              |       zlib-devel
# kdoctools             |       libxslt-devel docbook-style-xsl
# kwidgetsaddons        |       qt5-qttools-devel qt5-qttools-static
# kiconthemes           |       qt5-qtsvg-devel
# solid                 |       systemd-devel
# kdeclarative          |       qt5-qtquickcontrols2-devel libepoxy-devel
# kactivities           |       boost-devel
# kdewebkit             |       qt5-qtwebkit-devel
# kdelibs4support       |       libSM-devel pcre-devel qca-ossl openssl-devel
# khtml                 |       giflib-devel libjpeg-turbo-devel libpng-devel
# frameworkintegration  |       libXcursor-devel oxygen-fonts-devel
# ktexteditor           |       qt5-qtxmlpatterns-devel
# polkit-qt-1           |       polkit-devel
# phonon-gstreamer      |       gstreamer-devel gstreamer-plugins-bad-free-devel gstreamer1-plugins-bad-free-devel gstreamer1-plugins-base-devel
# networkmanager-qt     |       NetworkManager-devel NetworkManager-glib-devel
# baloo                 |       lmdb-devel
#-----------------------|---------------------------------
# WORKSPACE             |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# kwayland              |       wayland-devel libwayland-cursor-devel libwayland-server-devel
# kfilemetadata         |       libattr-devel
# libmm-qt              |       ModemManager-devel
# sddm-kcm              |       xcb-util-image-devel
# plasma-desktop        |       PackageKit-Qt5-devel xorg-x11-xkb-utils-devel
# user-manager          |       libpwquality-devel
# kcm-touchpad          |       xorg-x11-drv-synaptics-devel xorg-x11-server-devel
# kde-gtk-config        |       gtkmm24-devel gtkmm30-devel
# kwin                  |       libepoxy-devel
# oxygen-fonts          |       fontforge-devel
# gwenview              |       exiv2-devel
# libksane              |       sane-backends-devel
#-----------------------|---------------------------------
# APPLICATIONS          |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# gwenview              |       lcms2-devel
# lokalize              |       hunspell-devel
# kalgebra              |       glu
# parley                |       qt5-qtmultimedia qt5-qtmultimedia-devel
# step                  |       eigen3-devel
# rocs                  |       grentlee-devel
# telepathy-qt          |       qtsinglecoreapplication-devel
# ark                   |       libarchive-devel
# kmix                  |       alsa-lib alsa-lib-devel
# libkdegames           |       openal-soft-devel libsndfile-devel
# kcalc                 |       gmp-devel
# cups                  |       cups-devel
# ksirk                 |       qca2-devel qca-ossl qca-gnupg qca-pkcs11
#-----------------------|---------------------------------
# PIM                   |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# prison                |       libdmtx-devel qrencode-devel
# kcalcore              |       libical-devel
# kimap                 |       cyrus-sasl-devel
# kldap                 |       openldap-devel
# gpgmepp               |       gpgme-devel
#-----------------------|---------------------------------

# Install dependencies
#---------------------------
RUN dnf -y install gcc-c++ git doxygen cmake bzr vim tar && \
    dnf -y install dialog perl-libwww-perl perl-JSON perl-JSON-PP perl-XML-Parser perl-IPC-Cmd \
                    perl-YAML-LibYAML qt5-qtbase-devel && \
    dnf install -y \
                    qt5-qtscript-devel gettext-devel \
                    gperf \
                    flex bison \
                    qt5-qtx11extras-devel libXrender-devel xcb-util-keysyms-devel \
                    zlib-devel \
                    libxslt-devel docbook-style-xsl \
                    qt5-qttools-devel qt5-qttools-static \
                    qt5-qtsvg-devel \
                    systemd-devel \
                    qt5-qtquickcontrols2-devel libepoxy-devel\
                    boost-devel \
                    qt5-qtwebkit-devel \
                    libSM-devel pcre-devel qca-ossl openssl-devel \
                    giflib-devel libjpeg-turbo-devel libpng-devel \
                    libXcursor-devel oxygen-fonts-devel \
                    qt5-qtxmlpatterns-devel \
                    polkit-devel \
                    gstreamer-devel gstreamer-plugins-bad-free-devel gstreamer1-plugins-bad-free-devel gstreamer1-plugins-base-devel \
                                NetworkManager-devel NetworkManager-glib-devel NetworkManager-libnm-devel && \
    dnf install -y \
                    wayland-devel libwayland-cursor-devel libwayland-server-devel \
                    libattr-devel \
                    ModemManager-devel \
                    xcb-util-image-devel \
                    PackageKit-Qt5-devel xorg-x11-xkb-utils-devel \
                    libpwquality-devel \
                    xorg-x11-drv-synaptics-devel xorg-x11-server-devel \
                    gtkmm24-devel gtkmm30-devel \
                    lmdb-devel \
                    libepoxy-devel \
                    fontforge-devel \
                    exiv2-devel \
                    sane-backends-devel && \
    dnf install -y \ 
                    lcms2-devel \
                    hunspell-devel \
                    glui-devel \
                    qt5-qtmultimedia qt5-qtmultimedia-devel \
                    eigen3-devel \
                    grantlee-devel \
                    qtsinglecoreapplication-devel \
                    libarchive-devel \
                    alsa-lib alsa-lib-devel \
                    openal-soft-devel libsndfile-devel \
                    gmp-devel \
                    cups-devel \
                    qca-devel qca-ossl qca-gnupg qca-pkcs11 && \
    dnf install -y \ 
                    libdmtx-devel qrencode-devel \
                    libical-devel \
                    cyrus-sasl-devel \
                    openldap-devel \
                    gpgme-devel && \
    useradd -d /home/kdedev -m kdedev && \
    mkdir /work /qt && \
    chown kdedev /work /qt

# some symlinks in /root to handle sudo ./kdesrc-build
RUN ln -s /home/kdedev/.kdesrc-buildrc /root/.kdesrc-buildrc && \
    ln -s /home/kdedev/kdesrc-build /root/kdesrc-build
# setup kdedev account
RUN dnf install -y sudo && echo 'kdedev ALL=NOPASSWD: ALL' >> /etc/sudoers
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
