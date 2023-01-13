sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install
./configure --prefix=/usr \
 --disable-static \
 --with-curses \
 --docdir=/usr/share/doc/readline-$VERSION

 make SHLIB_LIBS="-lncursesw"

 make SHLIB_LIBS="-lncursesw" install

 install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-$VERSION