GPAW_INSTALL_ROOT=$(pwd)
SCALAPACK_INSTALL_DIR=$GPAW_INSTALL_ROOT/scalapack-install/
OPENBLAS_INSTALL_DIR=$GPAW_INSTALL_ROOT/openblas-install/

wget https://github.com/Reference-ScaLAPACK/scalapack/archive/v2.1.0.tar.gz
tar xvf v2.1.0.tar.gz
cd scalapack-2.1.0
mkdir build
cd build

CC="mpicc -O3 -march=native -mtune=native" FC="mpif90 -O3 -march=native -mtune=native" cmake .. -L -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$SCALAPACK_INSTALL_DIR -DBLAS_LIBRARIES="-L$OPENBLAS_INSTALL_DIR/lib/ -Wl,-rpath=$OPENBLAS_INSTALL_DIR/lib/ -lopenblas" -DLAPACK_LIBRARIES="-L$OPENBLAS_INSTALL_DIR/lib/ -Wl,-rpath=$OPENBLAS_INSTALL_DIR/lib/ -lopenblas" -DUSE_OPTIMIZED_LAPACK_BLAS=ON -DCMAKE_Fortran_FLAGS="-fallow-argument-mismatch"

make -j
make test
make install
