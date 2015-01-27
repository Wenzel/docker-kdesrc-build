#!/usr/bin/env bash


#------------------------------------------------------------------------------
#                               CONVENIENCE
#------------------------------------------------------------------------------
# quality
set -o errexit
set -o pipefail
# set -o xtrace

# script parent directory
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"

# colors
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
txtrst='\e[0m'    # Text Reset

#------------------------------------------------------------------------------
#                               USER CONFIGURATIO
#------------------------------------------------------------------------------

# mount point where KDE source code will be downloaded, compiled and installed
# for each distro
mnt_dir="$__dir/../mnt"

#------------------------------------------------------------------------------
#                               SCRIPT LOGIC
#------------------------------------------------------------------------------

no_cache="false"
base_system=""
# 1 - on which distro should we test the build ?
#-----------------------------------------------
declare -a arr_distro_to_test=

# parse parameters
finished=false
while [ "$finished" = "false" ]; do
    # take next param
    if [ ! -z "$1" ]; then
        new_arg=$1
        case "$new_arg" in
            "--nc")
                shift
                # ask for no-cache build in Docker
                no_cache="true"
                ;;
            "--base")
                shift
                # take next param as base system
                base_system=$1
                shift
                ;;
            *)
                # finished !
                finished=true
                ;;
        esac
    else
        finished=true
    fi
done


if [ -z "${base_system}" ]; then 
    # test on all distros available
    for i in echo $(cd "$__dir" && Dockerfile-*); do
        distro=${i#Dockerfile-}
        arr_distro_to_test+=("$distro")
    done
else
    arr_distro_to_test+=($base_system)
fi

check_mount_point ()
{
    local distro=$1
    echo -e "-> ${bldylw}Checking mount point${txtrst}"
    # check mnt/$distro/kdesrc-build dir
    if [ ! -d "$mnt_dir/$distro/kdesrc-build" ]; then
        mkdir -p "$mnt_dir/$distro"
        git clone git://anongit.kde.org/kdesrc-build "$mnt_dir/$distro/kdesrc-build"
        # copy rc
        cp "$__dir/kdesrc-buildrc" "$mnt_dir/$distro/kdesrc-build"
    fi
}

update_image ()
{
    local distro=$1
    echo -e "-> ${bldylw}Updating image${txtrst}"
    # ensure up to date
    docker build --no-cache="$no_cache" -t "$distro-kdedev" - < Dockerfile-$distro
}

run_kdesrc_build ()
{
    local distro=$1
    shift
    echo -e "-> ${bldylw}Run kdesrc-build${txtrst}"
    docker run -it --rm -v "$mnt_dir/$distro:/work" "$distro-kdedev" -c "cd kdesrc-build/ && git pull && ./kdesrc-build $@"
}

# update the container and run kdesrc-build for each distro
#~--------------------------------
for distro in ${arr_distro_to_test[@]}; do
    echo -e "\t${bldgrn}${distro}${txtrst}"
    check_mount_point $distro
    update_image $distro
    run_kdesrc_build $distro $@
done
