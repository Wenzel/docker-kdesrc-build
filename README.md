docker-kdesrc-build
===================
This project aims to provide Dockerfiles to KDE developers 
who would like to build the project from source with the `kdesrc-build` script, 
without messing with build dependencies and distro specific issues.

Tested distros
-----------------

* `Archlinux`
* `Ubuntu`
* `OpenSUSE` (TODO)
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
