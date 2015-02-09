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
* `KDE Frameworks 5`

Build
=====

First choose your favorite distro

    ln -sf Dockerfile-<distro> Dockerfile

Then run `docker build` to build the docker image

    docker build -t <distro>-kdedev .

Usage
=====

You can find more info about this script [on the KDE Wiki](https://techbase.kde.org/Getting_Started/Build/kdesrc-build)

Sources and QT libraries outside of the container
-------------------------------------------------

These images expect you to provide them with two volumes: 
* One pointing to the directory containing "kdesrc-build" which will be used 
to read kf5-frameworks-build-include and the included files in it. This allows
you to quickly modify some build options from your host session. "build" dir will
be used to store sources, build files and install files.
* Another one pointed to the base dir of the desired QT installation. This allows
you to easily select which QT version installed on your host OS will be used for
compilling KDE packages.

You just have to mount both volumes on the container

    docker run -ti -v ~/path/to/mnt/dir:/work -v /path/to/qt/base/dir:/qt <distro>-kdedev

On your host system, go into `/path/to/mnt/dir`, clone `kdesrc-build` and configure it.
When you want to build, get back on the `kdedev container` , and run `./kdesrc-build`

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

Without arguments, `build.sh` run `kdesrc-build` on all available distros.

Script syntax :

    ./build.sh [--base <distro>] [--nc] [kdesrc-build arg1] [kdesrc-build arg2]

        --nc    : --no-cache=true (build container from scratch)
        --base  : build container from Dockerfile-<distro> and run the kdesrc-build

TODO
====

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

In Workspace :

- `plasmate`

        CMake Error at /usr/share/cmake-3.1/Modules/FindPackageHandleStandardArgs.cmake:138 (message):
          Could NOT find KDevPlatform (missing: KDevPlatform_CONFIG) (Required is at
          least version "1.90.60")
        Call Stack (most recent call first):
          /usr/share/cmake-3.1/Modules/FindPackageHandleStandardArgs.cmake:374 (_FPHSA_FAILURE_MESSAGE)
          /work/full/install/lib64/cmake/KF5KDELibs4Support/FindKDevPlatform.cmake:44 (find_package_handle_standard_args)
          plasmate/CMakeLists.txt:20 (find_package)
