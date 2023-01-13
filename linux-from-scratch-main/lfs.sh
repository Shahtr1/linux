#!/bin/bash

export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu # a classic triplet to compilers to tell them i want something for 64 bit processor, a linux system, compiler wont have soemthing special for that vendor(lfs) and gnu , is the name of application binary interface
export LFS_DISK=/dev/sda

if ! grep -q "$LFS" /proc/mounts; then # this file tells you which systems are mounted on your system
    source setupdisk.sh "$LFS_DISK"
    sudo mount "${LFS_DISK}2" "$LFS"
    sudo chown -v $USER "$LFS"
fi

mkdir -pv $LFS/sources # download our tarball here
mkdir -pv $LFS/tools   # prelimnary cross-compiler will sit here

# FSH (file system hierarchy)
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
    ln -sv usr/$i $LFS/$i
done

case $(uname -m) in             # check if we are building for x64
    x86_64) mkdir -pv $LFS/lib64 ;;
esac


cp -rf *.sh chapter* packages.csv "$LFS/sources"
cd "$LFS/sources"
export PATH="$LFS/tools/bin:$PATH"

source download.sh

# Chapter 5
# for package in binutils gcc linux glibc libstdc++; do
#     source packageinstall.sh 5 $package
# done

# Chapter 6
# for package in m4 ncurses bash coreutils diffutils file findutils gawk grep gzip make patch sed tar xz binutils gcc; do
#     source packageinstall.sh 6 $package
# done


chmod ugo+x preparechroot.sh
chmod ugo+x insidechroot*.sh
chmod ugo+x teardownchroot.sh

# These two lines can replace the bottom loop
# ./chroot_bash.sh "$LFS" -c insidechroot.sh
# ./chroot_bash.sh "$LFS" -c insidechroot2.sh



sudo ./preparechroot.sh "$LFS"

# we will change root to $LFS, we will run our own compiled bash, and inside bash +h is to turn on history
# /usr/bin/env is a program to set ebvironment variables
# The -i option given to the env command will clear all variables of the chroot environment. After that, only the HOME, TERM, PS1, and PATH variables are set again.
# The TERM=$TERM construct will set the TERM variable inside chroot to the same value as outside chroot. This variable is needed for programs like vim and less to operate properly.
# From this point on, there is no need to use the LFS variable anymore because all work will be restricted to the LFS file system. This is because the Bash shell is told that $LFS is now the root (/) directory.
# /tools/bin is not in the PATH. This means that the cross toolchain will no longer be used in the chroot environment.
# bash prompt will say I have no name! This is normal because the /etc/passwd file has not been created yet.
# in book a new shell is created which will replace the old broken shell, in which there is connection with user, becaus ethere is no passwd and groups present, so instead of doing that we just exit out of chroot and make a new one chroot
for script in "/sources/insidechroot.sh" "/sources/insidechroot2.sh" "/sources/insidechroot3.sh"; do
    echo "RUNNING $script IN CHROOT ENVIRONMENT..."
    sleep 3
    sudo chroot "$LFS" /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin \
    /bin/bash --login +h -c "$script"
done

sudo ./teardownchroot.sh "$LFS" "$USER" "$(id -gn)"






