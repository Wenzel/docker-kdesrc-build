docker-kdesrc-build
===================
This project aims to provide Dockerfiles to KDE developers 
who would like to build the project from source with the `kdesrc-build` script, 
without messing with build dependencies and distro specific issues.

Tested distros
-----------------

* `Archlinux`
* `OpenSUSE`
* `Fedora`
* `Ubuntu` (TODO)

Dependencies installed
----------------------

* `kdesrc-build`
* `Frameworks`
* `Workspace`
* `Applications`
* `PIM`

Build
=====

First choose your favorite distro

    ln -sf Dockerfile-<distro> Dockerfile

Then run `docker build` to build the docker image

    docker build -t <distro>-kdedev .

Usage
=====

Simple
------
For a simple usage, just run the image

    docker run -ti <distro>-kdedev

Clone the build script somewhere, define a
`kdesrc-buildrc` config file and start building KDE.

    git clone git://anongit.kde.org/kdesrc-build.git
    cd kdesrc-build
    cp kdesrc-buildrc-kf5-sample kdesrc-buildrc
    vim kdesrc-buildrc # edit the rc file to setup your desired build
    ./kdesrc-build <args>

You can find more info about this script [on the KDE Wiki](https://techbase.kde.org/Getting_Started/Build/kdesrc-build)

Sources outside of the container
--------------------------------

Maybe you would like the keep the source code outside of the container,
so you can make changes with your favorite IDE and use the Docker container
to build KDE.

You just have to mount a volume on the container

    docker run -ti -v ~/path/to/mnt/dir:/work <distro>-kdedev

On your host system, go into `/path/to/mnt/dir`, clone `kdesrc-build` and configure it.
When you want to build, get back on the `kdedev container` , and run `./kdesrc-build`

Automated testing
-----------------

The `build.sh` script automates the process of building/updating the containers
and running `kdesrc-build` script inside of them.

Without arguments, `build.sh` runs `kdesrc-build` on all available distros.

Script syntax :

    ./build.sh [--base <distro>] [--nc] [kdesrc-build arg1] [kdesrc-build arg2]

        --nc    : --no-cache=true (build container from scratch)
        --base  : build container from Dockerfile-<distro> and run the kdesrc-build

TODO
====

Ubuntu
------

- Install latest Qt packages

Fedora
------

In Applications :

- `kdevlatform` : How to install `grantlee5` ?

        CMake Error at CMakeLists.txt:76 (find_package):
          By not providing "FindGrantlee5.cmake" in CMAKE_MODULE_PATH this project
          has asked CMake to find a package configuration file provided by
          "Grantlee5", but CMake did not find one.

          Could not find a package configuration file provided by "Grantlee5" with
          any of the following names:

            Grantlee5Config.cmake
            grantlee5-config.cmake

- `parley` : Need `Qt5Multimedia` development packages

        CMake Error at /usr/lib64/cmake/Qt5/Qt5Config.cmake:26 (find_package):
          Could not find a package configuration file provided by "Qt5Multimedia"
          with any of the following names:

            Qt5MultimediaConfig.cmake
            qt5multimedia-config.cmake

          Add the installation prefix of "Qt5Multimedia" to CMAKE_PREFIX_PATH or set
          "Qt5Multimedia_DIR" to a directory containing one of the above files.  If
          "Qt5Multimedia" provides a separate development package or SDK, be sure it
          has been installed.
        Call Stack (most recent call first):
          CMakeLists.txt:18 (find_package)

