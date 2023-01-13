#!/bin/bash

export LFS="$1"

if [ "$LFS" == "" ]; then
    exit 1
fi

chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}

case $(uname -m) in
    x86_64) chown -R root:root $LFS/lib64 ;;
esac

mkdir -pv $LFS/dev
mkdir -pv $LFS/proc
mkdir -pv $LFS/sys
mkdir -pv $LFS/run

# The below numbers are called majpor and minor numbers
# https://www.kernel.org/doc/Documentation/admin-guide/devices.txt
# The mknod command makes a directory entry and corresponding i-node for a special file.
# mknod was originally used to create the character and block devices that populate /dev/
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3

# if we enter chroot stuff might want to talk to devices, so we need dev directory
# so we make sth like a symlink, from orig dev to the LFS one.
mount -v --bind /dev $LFS/dev
mount -v --bind /dev/pts $LFS/dev/pts  # /dev/pts is where console session, which would be sth like a file also, so with command tty we can ask shell what is your file so /dev/pts contains ttys, we can send data to other ttys like echo Hello ? /dev/pts/5

mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys # communication with the kernel
mount -vt tmpfs tmpfs $LFS/run

# Here they are looking at location shm(shared memory), some distributions have put that interface to shared memory, not to dev/shm, they have put it probably to run/shm, so if its somewhere else, then they will still have symlink under position /dev/shm 
if [ -h $LFS/dev/shm ]; then
 mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi