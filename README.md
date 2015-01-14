docker-kdesrc-build
===================
This project aims to provide Dockerfiles to KDE developers 
who would like to build the project from source with the `kdesrc-build` script, 
without messing with build dependencies and distro specific issues.

Tested distros
-----------------

* `Archlinux`
* `Ubuntu`
* `OpenSUSE`
* `Fedora` (TODO)

Dependencies installed
----------------------

* `kdesrc-build`
* `KDE Frameworks 5`
* `KDE Workspace` (only `archlinux`)

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

Now you can login as simple user, clone the build script somewhere, define a
`kdesrc-buildrc` config file and start building KDE.

    su docker
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

TODO
====

Archlinux
----------

When building Workspace :

- `bluedevil`

        Cannot find libbludevil.cmake

- `libbluedevil`

        CMake Error: The following variables are used in this project, but they are set to NOTFOUND.
        Please set them or make sure they are set and tested correctly in the CMake files:
        QT_QT_INCLUDE_DIR (ADVANCED)
            used as include directory in directory /work/full/source/kde/workspace/libbluedevil/bluedevil
            used as include directory in directory /work/full/source/kde/workspace/libbluedevil/bluedevil/test
            used as include directory in directory /work/full/source/kde/workspace/libbluedevil/bluedevil/test

- `plasmate`

        CMake Error at /usr/share/cmake-3.1/Modules/FindPackageHandleStandardArgs.cmake:138 (message):
        Could NOT find KDevPlatform (missing: KDevPlatform_CONFIG) (Required is at
        least version "1.90.60")

OpenSUSE
--------

- `libdbusmenu-qt`

        Make Error in src/CMakeLists.txt:
        Target "dbusmenu-qt5" INTERFACE_INCLUDE_DIRECTORIES property contains
        relative path:
        "include/dbusmenu-qt5"
