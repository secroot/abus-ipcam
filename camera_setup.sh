#!/bin/sh
# camera_setup.sh - Prepare the running Linux system for the ABUS IP camera.
# This script mounts basic filesystems and creates device nodes.

set -e

mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t tmpfs -o mode=0755 tmpfs /dev

mknod -m 622 /dev/console c 5 1
mknod -m 666 /dev/null c 1 3
mknod -m 666 /dev/zero c 1 5
mknod -m 666 /dev/ttyS0 c 4 64
mknod -m 666 /dev/ttyS1 c 4 65

chmod 666 /dev/null /dev/zero
