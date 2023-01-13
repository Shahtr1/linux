./configure --prefix=/usr
make -j$(nproc)
make check
make install