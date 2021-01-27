GPAW_INSTALL_ROOT=$(pwd)
OPENBLAS_INSTALL_DIR=$GPAW_INSTALL_ROOT/openblas-install

git clone https://github.com/xianyi/OpenBLAS.git
cd OpenBLAS
git checkout v0.3.9
make TARGET=ZEN DYNAMIC_ARCH=1
make PREFIX=$OPENBLAS_INSTALL_DIR install
