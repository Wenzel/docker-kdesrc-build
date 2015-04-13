#!/usr/bin/python3

"""
Usage: build.py [options] [--] [<kdesrc-build-args>...]

Options:
    -b --base DISTRO    Use DISTRO as base system [Default: all]
    --no-cache          Do not use cache when building the image
    -h --help           Display this message

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
        regexp_str = '^Dockerfile-(' + sel_distro + ')$'
    reg = re.compile(regexp_str)
    for i in os.listdir(__SCRIPT_CUR_DIR):
        if reg.match(i):
            avail_templates.append( reg.match(i).group(1) )
    return avail_templates


def check_mnt_point(template):
    print("Checking mount point for " + template)
    path = MNT_DIR + '/' + template
    os.makedirs(path, exist_ok=True)

def update_image(template, cache_enabled):
    print("Updating image for " + template)
    source = 'Dockerfile-' + template
    dest = 'Dockerfile'
    if os.path.exists(dest):
        os.remove(dest)
    os.symlink(source, dest)
    subprocess.call(['docker',
        'build',
        '--no-cache=' + str(cache_enabled),
        '-t',
        template + '-kdedev',
        '.'
    ])

def run_kdesrc_build(template, kdesrc_args):
    host_mnt_dir = MNT_DIR + '/' + template
    subprocess.call(['docker',
        'run',
        '-it',
        '--rm',
        '-v', host_mnt_dir + ':/work',
        template + '-kdedev',
        '-c',
        'cd kdesrc-build && git pull && ./kdesrc-build ' + ' '.join(kdesrc_args)
    ])

if __name__ == '__main__':
    args = docopt(__doc__)
    print(args)
    templates = check_templates(args['--base'])
    os.makedirs(MNT_DIR, exist_ok=True)
    for i in templates:
        print(i)
        check_mnt_point(i)
        update_image(i, args['--no-cache'])
        run_kdesrc_build(i, args['<kdesrc-build-args>'])
