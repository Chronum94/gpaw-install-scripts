GPAW_INSTALL_ROOT=$(pwd)
FFTW3_INSTALL_DIR=$GPAW_INSTALL_ROOT/fftw-install/
LIBVDWXC_INSTALL_DIR=$GPAW_INSTALL_ROOT/libvdwxc-install/

git clone https://gitlab.com/libvdwxc/libvdwxc.git
cd libvdwxc
autoreconf -i
mkdir build
cd build

MPI_LIBS="-L/$MPILIBDIR -lmpi" CC=mpicc FC=mpif90 CFLAGS="-mavx -mtune=native -O3 -ftree-vectorize" FFTW3_INCLUDES="-I$FFTW3_INSTALL_DIR/include" FFTW3_LIBS="-L$FFTW3_INSTALL_DIR/lib -lfftw3 -lfftw3_mpi" ../configure --prefix=$LIBVDWXC_INSTALL_DIR
make -j
