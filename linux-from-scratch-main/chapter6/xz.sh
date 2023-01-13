./configure --prefix=/usr \
 --host=$LFS_TGT \
 --build=$(build-aux/config.guess) \
 --disable-static \
 --docdir=/usr/share/doc/xz-$VERSION \
&& make -j$(nproc) \
&& make DESTDIR=$LFS install

rm -v $LFS/usr/lib/liblzma.la