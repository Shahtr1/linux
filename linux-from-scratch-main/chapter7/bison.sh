./configure --prefix=/usr \
 --docdir=/usr/share/doc/bison-3.8.2 \
&& make -j$(nproc) \
&& make install