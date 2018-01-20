FROM opensuse:42.3
MAINTAINER Mathieu Tarral <mathieu.tarral@gmail.com>

# FRAMEWORKS            |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# libdbusmenu-qt        |       libQt5DBus-devel ca-certificates-mozilla
# attica                |       libQt5Test-devel
# ki18n                 |       gettext-tools libQt5Concurrent-devel libqt5-qtscript-devel
# kwindowsystem         |       libqt5-x11extras-devel xcb-util-keysyms-devel
# kdoctools             |       libxslt-devel docbook-xsl-stylesheets
# kwidgetsaddons        |       libqt5-qttools-devel
# kxml-gui              |       libQt5PrintSupport-devel
# solid                 |       libudev-devel
# kiconthemes           |       libqt5-qtsvg-devel
# kdeclarative          |       libepoxy-devel
# kactivities           |       boost-devel
# kdewebkit             |       libQt5WebkKit5-devel libQt5WebKitWidgets-devel
# khtml                 |       giflib-devel
# frameworkintegration  |       libQt5PlatformSupport-private-headers-devel
# ktexteditor           |       libqt5-qtxmlpatters-devel
# polkit-qt-1           |       libpolkit-qt-1-devel
# phonon-vlc            |       vlc-devel
# phonon-gstreamer      |       libQt5OpenGL-devel gstreamer-editing-services-devel
# modemmanager-qt       |       ModemManager-devel
# networkmanager-qt     |       NetworkManager-devel
# baloo                 |       libxapian-devel lmdb-devel
#-----------------------|---------------------------------
# WORKSPACE             |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# user-manager          |       libpwquality-devel
# kde-gtk-config        |       gtk2-devel gtk3-devel
# kfilemetadata         |       libattr-devel
# oxygen-fonts          |       fontforge-devel
# kwayland              |       wayland-devel
# kwin                  |       xcb-util-image-devel xcb-util-cursor-devel
# kcm-touchpad          |       xf86-input-synaptics-devel xorg-x11-util-devel libX11-devel  libxkbcommon-x11-devel xf86-input-wacom-devel
#-----------------------|---------------------------------
# APPLICATIONS          |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# kdevplatform          |       grantlee5-devel
# gwenview              |       libexiv2-devel
# lokalize              |       hunspell-devel
# libksane              |       sane-backends-devel
# kalgebra              |       glu-devel
# marble                |       automoc4
# parley                |       libqt5-qtmultimedia-devel
# step                  |       eigen3-devel
# kcalc                 |       gmp-devel
# print-manager         |       cups-devel
# ark                   |       libarchive-devel
# kmix                  |       alsa-devel
# libkdegames           |       libsndfile-devel openal-soft-devel
# ksirk                 |       libqca-qt5-devel
#-----------------------|---------------------------------
# PIM                   |       BUILD DEPENDENCY
#-----------------------|---------------------------------
# prison                |       libdmtx-devel qrencode-devel
# kcalcore              |       libical-devel
# kimap                 |       cyrus-sasl-devel
# kldap                 |       openldap2-devel
# gpgmepp               |       libgpgme-devel
#-----------------------|---------------------------------


# install dependencies
#---------------------
RUN zypper --non-interactive in vim tar git bzr cmake doxygen
RUN zypper --non-interactive in perl-libwww-perl perl-XML-Parser perl-JSON perl-YAML-LibYAML perl-IO-Socket-SSL \
                                    dialog python ca-certificates libqt4-devel
RUN zypper --non-interactive in --force-resolution \
        libQt5DBus-devel ca-certificates-mozilla \
        libQt5Test-devel \
        gettext-tools libQt5Concurrent-devel libqt5-qtscript-devel \
        libqt5-qtx11extras-devel xcb-util-keysyms-devel \
        libxslt-devel docbook-xsl-stylesheets \
        libqt5-qttools-devel \
        libQt5PrintSupport-devel \
        libudev-devel \
        libqt5-qtsvg-devel \
        libepoxy-devel \
        boost-devel \
        libQt5WebKit5-devel libQt5WebKitWidgets-devel \
        giflib-devel \
        libQt5PlatformSupport-private-headers-devel \
        libqt5-qtxmlpatterns-devel \
        libpolkit-qt-1-devel \
        vlc-devel \
        libQt5OpenGL-devel gstreamer-editing-services-devel \
        ModemManager-devel \
        NetworkManager-devel
RUN zypper --non-interactive in \
        libpwquality-devel \
        gtk2-devel gtk3-devel \
        libattr-devel \
        fontforge-devel \
        xcb-util-image-devel \
        xf86-input-synaptics-devel xorg-x11-util-devel libX11-devel  libxkbcommon-x11-devel xf86-input-wacom-devel \
        libxapian-devel lmdb-devel
RUN zypper --non-interactive in \
                              grantlee5-devel \
                              libexiv2-devel \
                              hunspell-devel \
                              sane-backends-devel \
                              glu-devel \
                              automoc4 \
                              libqt5-qtmultimedia-devel \
                              eigen3-devel \
                              gmp-devel \
                              cups-devel \
                              libarchive-devel \
                              alsa-devel \
                              libsndfile-devel openal-soft-devel \
                              libqca-qt5-devel
RUN zypper --non-interactive in \
                                libdmtx-devel qrencode-devel \
                                libical-devel \
                                cyrus-sasl-devel \
                                openldap2-devel \
                                libgpgme-devel
# some commands needed by startkde script
RUN zypper --non-interactive in xset xsetroot xprop

RUN useradd -d /home/kdedev -m kdedev && \
    mkdir /work /qt && \
    chown kdedev /work /qt

# some symlinks in /root to handle sudo ./kdesrc-build
RUN ln -s /home/kdedev/.kdesrc-buildrc /root/.kdesrc-buildrc && \
    ln -s /home/kdedev/kdesrc-build /root/kdesrc-build
# setup kdedev account
RUN zypper --non-interactive in sudo && \
    echo 'kdedev ALL=NOPASSWD: ALL' >> /etc/sudoers && \
    gpasswd -a kdedev video
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
