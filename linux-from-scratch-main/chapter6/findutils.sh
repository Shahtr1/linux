./configure --prefix=/usr \
 --localstatedir=/var/lib/locate \
 --host=$LFS_TGT \
 --build=$(build-aux/config.guess) \
&& make -j$(nproc) \
&& make DESTDIR=$LFS install