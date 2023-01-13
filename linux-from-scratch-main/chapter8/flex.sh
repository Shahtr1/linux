./configure --prefix=/usr \
 --docdir=/usr/share/doc/flex-$VERSION \
 --disable-static

make -j$(nproc)
make check
make install

ln -sv flex /usr/bin/lex