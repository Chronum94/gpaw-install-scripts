GPAW_INSTALL_ROOT=$(pwd)
LIBXC_INSTALL_DIR=$GPAW_INSTALL_ROOT/libxc-install

git clone https://gitlab.com/libxc/libxc.git
cd libxc
git tag
git checkout 4.3.4

mkdir objdir && cd objdir
cmake .. -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=$LIBXC_INSTALL_DIR -DENABLE_FORTRAN=ON -DENABLE_FORTRAN03=ON
make -j
make test
make install
