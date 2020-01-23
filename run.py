#!/usr/bin/env python3

"""
Usage:  run.py [options]
        run.py [options] [--] execute <commands>...

Options:
    -b --base DISTRO        Use DISTRO as base system [Default: all]
    --no-cache              Do not use cache when building the image [Default: False]
    --rm                    Automatically remove the container when it exits [Default: True]
    --display DISPLAY       Change the DISPLAY environment variable passed to the container [Default: :0]
    --vnc                   Enable port forwarding and disable X11 socket sharing
    --noninteractive        Disable TTY allocation and stdin (useful for CI test)
    --qt PATH               Set the PATH to your a specified Qt installation (mounted as /qt) [Default: False]
    -h --help               Display this message

"""

from docopt import docopt
import os
import sys
import re
import subprocess

MNT_DIR = os.path.expanduser('~') + '/kdebuild'

__SCRIPT_CUR_DIR = os.path.dirname(os.path.realpath(sys.argv[0]))

def check_templates(sel_distro):
    regexp_str = ''
    avail_templates = []
    if sel_distro == 'all':
        regexp_str = '^Dockerfile-(.+)$'
    else:
        regexp_str = '^Dockerfile-({})$'.format(sel_distro)
    reg = re.compile(regexp_str)
    for i in os.listdir(__SCRIPT_CUR_DIR):
        if reg.match(i):
            avail_templates.append( reg.match(i).group(1) )
    return avail_templates


def check_mnt_point(template):
    print("Checking mount point for {}".format(template))
    path = '{}/{}'.format(MNT_DIR, template)
    os.makedirs(path, exist_ok=True)

def update_image(template, cache_enabled):
    print("Updating image for " + template)
    subprocess.call(['docker',
        'build',
        '--no-cache={}'.format(str(cache_enabled)),
        '-t',
        '{}-kdedev'.format(template),
        '-f', 'Dockerfile-{}'.format(template),
        '.'
    ], cwd=__SCRIPT_CUR_DIR)

def run_kdesrc_build(template, auto_rm_enabled, display, vnc_enabled, qt_dir,
        noninteractive, commands):
    host_mnt_dir = '{}/{}'.format(MNT_DIR, template)
    # vnc vs x11socket
    xsocket = ''
    vnc = ''
    if vnc_enabled:
        vnc = ['-p', '127.0.0.1:5900:5900']
    else:
        xsocket = [ '-v', '/tmp/.X11-unix:/tmp/.X11-unix:ro' ]
    # qt volume
    qt_mount = ''
    if qt_dir != 'False':
        qt_mount = [ '-v', '{}:/qt'.format(qt_dir) ]
    interactive = '-it'
    if noninteractive:
        interactive = ''
    # create subp_cmd
    subp_cmd = [
        'docker',
        'run',
        interactive,
        '--privileged',
        '--rm={}'.format(str(auto_rm_enabled)),
        '-e', 'DISPLAY={}'.format(display),
    ]
    subp_cmd.extend([
        '-v', '{}:/work'.format(host_mnt_dir),
        '-v', __SCRIPT_CUR_DIR + '/kdesrc-buildrc:/home/kdedev/.kdesrc-buildrc',
        '-v', __SCRIPT_CUR_DIR + '/bashrc:/home/kdedev/.bashrc',
    ])
    subp_cmd.extend(xsocket)
    subp_cmd.extend(vnc)
    subp_cmd.extend(qt_mount)
    subp_cmd.extend([
        '{}-kdedev'.format(template),
    ])
    # commands
    if commands:
        subp_cmd.extend(commands)
    # run
    return subprocess.call(subp_cmd)

if __name__ == '__main__':
    args = docopt(__doc__)
    templates = check_templates(args['--base'])
    os.makedirs(MNT_DIR, exist_ok=True)
    commands = args['<commands>'] if args['<commands>'] else None
    for i in templates:
        print(i)
        check_mnt_point(i)
        update_image(i, args['--no-cache'])
        exit_code = run_kdesrc_build(i, args['--rm'], args['--display'], args['--vnc'], args['--qt'],
                args['--noninteractive'], commands)
        if exit_code != 0:
            sys.exit(exit_code)
