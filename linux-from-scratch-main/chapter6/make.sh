./configure --prefix=/usr \
 --without-guile \
 --host=$LFS_TGT \
 --build=$(build-aux/config.guess) \
&& make -j$(nproc) \
&& make DESTDIR=$LFS install