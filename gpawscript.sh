INSTALLROOT=$(pwd)
SITECONFIG="test.py"
if [ -d $INSTALLROOT/fftw-install/ ]
then
    HAS_FFTW_INSTALLED=true
fi

if [ -d $INSTALLROOT/scalapack-install/ ]
then
    HAS_SCALAPACK_INSTALLED=true
fi

if [ -d $INSTALLROOT/elpa-install/ ]
then
    HAS_ELPA_INSTALLED=true
fi

cat > $SITECONFIG << EOL
# BLAS and some optimization flags.
include_dirs += [installroot + 'openblas-install/include/']
extra_link_args +=[installroot + 'openblas-install/lib/libopenblas.a']
extra_compile_args += ['-mavx2', '-march=native', '-mtune=native']
compiler = 'mpicc'

# LibXC is compulsory.
xc = installroot + 'libxc-install/'
include_dirs += [xc + 'include/']
extra_link_args += [xc + 'lib64/libxc.a']
if 'xc' in libraries:
    libraries.remove('xc')
    
EOL

if [ HAS_FFTW_INSTALLED ]
then
cat >> $SITECONFIG << EOL
fftw=True
include_dirs += [installroot + 'fftw-install/include']
library_dirs += [installroot + 'fftw-install/lib']
extra_link_args += ['-Wl,-rpath=' + installroot + 'fftw-install/lib']
libraries += ['fftw3', 'fftw3_mpi']

EOL
fi

if [ HAS_SCALAPACK_INSTALLED ]
then
cat >> $SITECONFIG << EOL
scalapack = True
if scalapack:
    libraries += ['scalapack']
    library_dirs += [installroot + 'scalapack-install/lib']
    extra_link_args += ['-Wl,-rpath=' + installroot + 'scalapack-install/lib']

EOL
fi

if [ HAS_ELPA_INSTALLED ]
then
cat >> $SITECONFIG << EOL
elpa = True
elpadir = '/home/chronum/GPAW/elpa-install'
libraries += ['elpa']
library_dirs += ['{}/lib'.format(elpadir)]
extra_link_args += ['-Wl,-rpath={}/lib'.format(elpadir)]
include_dirs += ['{}/include/elpa-2020.11.001'.format(elpadir)]

EOL
fi
