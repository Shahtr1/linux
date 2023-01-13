./configure --prefix=/usr \
 --disable-static \
 --docdir=/usr/share/doc/xz-$VERSION
 make
 make check
 make install