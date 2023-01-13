LFS_DISK="$1"

sudo fdisk "$LFS_DISK" << EOF
o
n
p
1

+100M
a
n
p
2


p
w
q
EOF

# o creates a new partition table
# n creates a new partition on that disk
# a mainboard will look for this flag, if it isnt set then main board will not even try to boot from it
# q for quit

sudo mkfs -t ext2 -F "${LFS_DISK}1"
sudo mkfs -t ext2 -F "${LFS_DISK}2"