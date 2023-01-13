./configure --prefix=/usr \
 --enable-shared \
 --without-ensurepip \
&& make -j$(nproc) \
&& make install