mkdir mpfr gmp mpc
tar -xf ../mpfr-*.tar.xz -C mpfr --strip-components=1
tar -xf ../gmp-*.tar.xz -C gmp --strip-components=1
tar -xf ../mpc-*.tar.gz -C mpc --strip-components=1

case $(uname -m) in
 x86_64)
 sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
 ;;
esac

sed '/thread_header =/s/@.*@/gthr-posix.h/' \
 -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

mkdir -v build
cd build

../configure \
 --build=$(../config.guess) \
 --host=$LFS_TGT \
 --target=$LFS_TGT \
 LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc \
 --prefix=/usr \
 --with-build-sysroot=$LFS \
 --enable-initfini-array \
 --disable-nls \
 --disable-multilib \
 --disable-decimal-float \
 --disable-libatomic \
 --disable-libgomp \
 --disable-libquadmath \
 --disable-libssp \
 --disable-libvtv \
 --enable-languages=c,c++ \
&& make -j$(nproc) \
&& make DESTDIR=$LFS install

ln -sv gcc $LFS/usr/bin/cc