docker-kdesrc-build
===================
This project aims to provide Dockerfiles to KDE developers 
who would like to build the project from source with the `kdesrc-build` script, 
without messing with build dependencies and distro specific issues.

Tested distros
-----------------

* `Archlinux`
* `OpenSUSE`
* `Ubuntu` (TODO)
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

In Frameworks :

- `solid`

        -- The following REQUIRED packages have not been found:
         * UDev , UDev support for Solid , <http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html>
           Allows Solid to use UDev to provide information about devices on Linux

Ubuntu
------

In Frameworks :

- `kdeclarative` :

        Building CXX object tests/CMakeFiles/kdeclarativetest.dir/kdeclarativetest_automoc.cpp.o
        /work/full/source/frameworks/kdeclarative/src/qmlcontrols/kquickcontrolsaddons/plotter.cpp: In constructor 'PlotTexture::PlotTexture(QOpenGLContext*)':
        /work/full/source/frameworks/kdeclarative/src/qmlcontrols/kquickcontrolsaddons/plotter.cpp:210:14: error: 'class QOpenGLContext' has no member named 'isOpenGLES'
             if (ctx->isOpenGLES()) {
                      ^
        /work/full/source/frameworks/kdeclarative/src/qmlcontrols/kquickcontrolsaddons/plotter.cpp: In member function 'virtual QSGNode* Plotter::updatePaintNode(QSGNode*, QQuickItem::UpdatePaintNodeData*)':
        /work/full/source/frameworks/kdeclarative/src/qmlcontrols/kquickcontrolsaddons/plotter.cpp:643:18: error: 'class QOpenGLContext' has no member named 'isOpenGLES'
                 if (ctx->isOpenGLES()) {
                          ^
        make[2]: *** [src/qmlcontrols/kquickcontrolsaddons/CMakeFiles/kquickcontrolsaddonsplugin.dir/plotter.cpp.o] Error 1
        make[2]: *** Waiting for unfinished jobs....
        make[1]: *** [src/qmlcontrols/kquickcontrolsaddons/CMakeFiles/kquickcontrolsaddonsplugin.dir/all] Error 2
        make[1]: *** Waiting for unfinished jobs....
        /work/full/source/frameworks/kdeclarative/tests/kdeclarativetest.cpp: In function 'int main(int, char**)':
        /work/full/source/frameworks/kdeclarative/tests/kdeclarativetest.cpp:39:29: warning: 'void KDeclarative::KDeclarative::initialize()' is deprecated (declared at /work/full/source/frameworks/kdeclarative/tests/../src/kdeclarative/kdeclarative.h:45) [-Wdeprecated-declarations]
             kdeclarative.initialize();
                                     ^

