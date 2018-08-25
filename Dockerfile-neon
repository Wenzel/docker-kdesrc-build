FROM kdeneon/plasma:dev-unstable
MAINTAINER Luca Carlon <carlon.luca@gmail.com>

# Install dependencies
#---------------------------
# set noninteractive frontend only during build
ARG DEBIAN_FRONTEND=noninteractive
RUN sudo apt-get update && \
    sudo apt-key adv --recv-keys && \
    sudo apt-get install -y git bzr vim g++ cmake tar doxygen && \
    sudo apt-get install -y libwww-perl libxml-parser-perl libjson-perl libyaml-libyaml-perl dialog gettext libxrender-dev pkg-config libxcb-keysyms1-dev docbook-xsl libxslt1-dev libxml2-utils libudev-dev libqt4-dev && \
    sudo apt-get install -y \
                        gperf \
                        flex bison \
                        qtscript5-dev \
                        libqt5x11extras5-dev \
                        qttools5-dev \
                        libqt5svg5-dev \
                        libgcrypt20-dev \
                        libepoxy-dev \
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
                        qtbase5-private-dev libqt5webenginewidgets5 qtquickcontrols2-5-dev qtdeclarative5-dev libqt5sensors5-dev libqt5texttospeech5-dev libqt5websockets5-dev qtwebengine5-dev qtmultimedia5-dev \
                        libxcb-damage0-dev libxcb-composite0-dev libxcb-cursor-dev libxcb-icccm4-dev libxcb-dpms0 signond-dev libxcb-image0-dev libxcb-xkb-dev libxcb-dpms0-dev libxcb-util-dev \
                        libavcodec-dev libavfilter-dev libavformat-dev libavdevice-dev libavutil-dev libswscale-dev libpostproc-dev \
                        libqrencode-dev liblmdb-dev libnm-dev libattr1-dev libaccounts-qt5-dev \
                        libsignon-qt5-dev libaccounts-glib-dev qml-module-org-kde-kquickcontrols qml-module-org-kde-kquickcontrolsaddons \
                        intltool libassuan-dev gpgsm liblcms2-dev libexiv2-dev libgphoto2-dev libclang-dev llvm-dev libsane-dev \
                        libpam0g-dev libgrantlee5-dev \
                        libxapian-dev libqca-qt5-2-dev libxcb-xtest0-dev libpulse-dev libcanberra-dev \
                        libvncserver-dev libmission-control-plugins-dev libsignon-glib-dev \
                        libxkbfile-dev libxt-dev libasound2-dev libsphinxbase-dev libqwt-dev libqwt-qt5-dev \
                        libfreetype6-dev libfontconfig-dev libmtdev-dev libevdev-dev libwacom-dev graphviz \
                        texinfo libxtst-dev libgconf2-dev libpwquality-dev \
                        libopencv-dev libeigen3-dev libappstreamqt-dev \
                        libgtk2.0-dev libgtk-3-dev libraw-dev \
                        libhunspell-dev libtelepathy-qt5-dev libakonadi-dev libarchive-dev libsamplerate0-dev libdiscid-dev libmlt-dev libmlt++-dev libflac++-dev libflac-dev libsndfile1-dev libid3-3.8.3-dev \
                        libtag1-dev libaudiofile-dev libopenal-dev libcdparanoia-dev \
                        libnm-glib-dev modemmanager-dev bash-completion libcups2-dev libmad0-dev libopus-dev fftw3 fftw3-dev libfreecell-solver-dev \
                        python3-twisted libcurl4-openssl-dev libssl-dev && \
    sudo useradd -d /home/kdedev -m kdedev && \
    sudo mkdir /work /qt && \
    sudo chown kdedev /work /qt

# some symlinks in /root to handle sudo ./kdesrc-build
RUN sudo ln -s /home/kdedev/.kdesrc-buildrc /root/.kdesrc-buildrc && \
    sudo ln -s /home/kdedev/kdesrc-build /root/kdesrc-build
# setup kdedev account
RUN sudo apt-get install -y sudo && sudo bash -c "echo 'kdedev ALL=NOPASSWD: ALL' >>  /etc/sudoers"
RUN sudo mkdir /usr/lib/x86_64-linux-gnu/signon/extensions
RUN sudo mkdir /usr/lib/mission-control-plugins.0
RUN sudo chmod 777 /usr/lib/mission-control-plugins.0
RUN sudo chmod 777 /usr/lib/x86_64-linux-gnu/signon/extensions
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
