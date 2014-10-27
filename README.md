docker-kdesrc-build
===================
This project aims to provide containers to KDE developers 
who would like to build the project from source with the `kdesrc-build` script, 
without messing with package dependencies and distro specific issues.

Build
=====

First choose the distro your favorite distro

    ln -sf Docker-<distro> Dockerfile

Then run `docker build` to build the docker image

    docker build -t <distro>-kdedev .

Usage
=====

Simple
------
For a simple usage, just run the image

    docker run -ti <distro>-kdedev /bin/bash

Now you can login as simple user, clone the build script somewhere, define a
`kdesrc-buildrc` config file and start building KDE.

    su docker
    cd /work
    git clone git://anongit.kde.org/kdesrc-build.git
    cd kdesrc-build
    cp kdesrc-buildrc-kf5-sample kdesrc-buildrc
    vim kdesrc-buildrc
    ./kdesrc-build <args>

You can find more info about this script [on the KDE Wiki](https://techbase.kde.org/Getting_Started/Build/kdesrc-build)

Sources outside of the container
--------------------------------

Maybe you would like the keep the source code outside of the container,
so you can make changes with your favorite IDE and just use the container
to build KDE.

You just have to mount a volume on the container

    docker run -ti -v ~/path/to/mnt/dir:/work <distro>-kdedev

And here you go !
