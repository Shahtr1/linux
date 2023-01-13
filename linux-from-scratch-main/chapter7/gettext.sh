./configure --disable-shared \
&& make -j$(nproc) \
&& cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin