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

* configure `kdesrc-buildrc` in `/home/kdedev/.kdesrc-buildrc`
* When you want to build, run the `./kdesrc-build` script. (in `/home/kdedev/kdesrc-build/`)

You can find more info about this script [on the KDE Wiki](https://techbase.kde.org/Getting_Started/Build/kdesrc-build)

Sources outside of the container
--------------------------------

You can keep the source code and the build outside of the container by
mounting the `/work` volume :

    docker run -ti -v ~/path/to/mnt/dir:/work <distro>-kdedev

Qt libraries outside of the container
--------------------------------

You can provide the container with a path to the base dir of the desired QT installation. This allows
you to easily select which QT version installed on your host OS will be used for
compiling KDE packages.

add the following options to the commandline :

    -v ~/path/to/qtbase/dir:/qt

/path/to/qt/base/dir might be /usr if you want to use your host's OS distro QT
installation. If you have installed different QT versions by yourself this path 
might look something like this: <qt_base_dir>/5.4/gcc_64/

Files owner and permissions
---------------------------

This images create a new user (kdedev) with UID=1000. If your user in your host 
OS has the same UID you will be able to seamesly open, edit and run files created
by the docker container from you host OS. If this is not the case, you will find
bindfs useful in order to map containers UID to your desired host's UID.

Example: 
    sudo bindfs -u 1000 -g 1000 --create-for-user=<your_users_uid> --create-for-group=<your_users_gid> /origin/work/dir/ /dest/work/dir/

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


Archlinux
----------

In Workspace :

- `plasmate`

        CMake Error at /usr/share/cmake-3.1/Modules/FindPackageHandleStandardArgs.cmake:138 (message):
          Could NOT find KDevPlatform (missing: KDevPlatform_CONFIG) (Required is at
          least version "1.90.60")
        Call Stack (most recent call first):
          /usr/share/cmake-3.1/Modules/FindPackageHandleStandardArgs.cmake:374 (_FPHSA_FAILURE_MESSAGE)
          /work/full/install/lib64/cmake/KF5KDELibs4Support/FindKDevPlatform.cmake:44 (find_package_handle_standard_args)
          plasmate/CMakeLists.txt:20 (find_package)

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

