expect -c "spawn ls"
mkdir -v build
cd build

../configure --prefix=/usr \
 --sysconfdir=/etc \
 --enable-gold \
 --enable-ld=default \
 --enable-plugins \
 --enable-shared \
 --disable-werror \
 --enable-64-bit-bfd \
 --with-system-zlib

 make -j$(nproc) tooldir=/usr

 make -k check

 make tooldir=/usr install

 rm -fv /usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.a
