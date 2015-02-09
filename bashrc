### KDE-specific environment variables:
# KDE supports various environment variables that might be useful for your
# kdesrc-build desktop. See also:
# http://techbase.kde.org/KDE_System_Administration/Environment_Variables

KDE_COLOR_DEBUG=1
export KDE_COLOR_DEBUG # Be sure to "export" variables you set yourself.

# If more user customizations to the environment are needed, you can add them
# here.
export CMAKE_PREFIX_PATH="/qt/lib/cmake/"
export PATH="/home/kdedev/kdesrc-build/:$PATH"
