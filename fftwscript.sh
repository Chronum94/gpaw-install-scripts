GPAW_INSTALL_ROOT=$(pwd)
FFTW_INSTALL_DIR=$GPAW_INSTALL_ROOT/fftw-install

wget http://www.fftw.org/fftw-3.3.8.tar.gz
tar xvf fftw-3.3.8.tar.gz

cd fftw-3.3.8

CFLAGS="-O3 -fomit-frame-pointer -mtune=native -malign-double -fstrict-aliasing -fno-schedule-insns -ffast-math" ./configure --enable-mpi --enable-openmp --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 --enable-threads --enable-shared --prefix=$FFTW_INSTALL_DIR CC=gcc
make -j
make test
make install

