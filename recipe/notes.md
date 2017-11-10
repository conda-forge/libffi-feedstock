# To regenerate 0004-Update-to-libtool-2.4.6.34.patch
# .. first fix libtool so that static libraries have
#    a lib prefix, then run:
[[ -d /tmp/0004-regen ]] && rm -rf /tmp/0004-regen
mkdir /tmp/0004-regen
pushd /tmp/0004-regen
  git clone /f/upstreams/libtool
  pushd libtool
    AUTOMAKE=/usr/bin/automake-1.13 ACLOCAL=/usr/bin/aclocal-1.13 ./bootstrap
    ./configure --prefix=/tmp/test/libtool-install
    make && make install
  popd
  wget -c ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz
  tar -xf libffi-3.2.1.tar.gz
  git clone -b v3.2.1 --single-branch /f/upstreams/libffi
  cp -f libffi-3.2.1/{aclocal.m4,compile,config.guess,config.sub,configure,depcomp,fficonfig.h.in,install-sh,ltmain.sh,Makefile.in,mdate-sh,missing} libffi/
  cp -f libffi-3.2.1/m4/{libtool.m4,lt~obsolete.m4,ltoptions.m4,ltsugar.m4,ltversion.m4} libffi/m4/
  cp -f libffi-3.2.1/include/Makefile.in libffi/include/
  cp -f libffi-3.2.1/man/Makefile.in libffi/man/
  cp -f libffi-3.2.1/testsuite/Makefile.in libffi/testsuite/
  pushd libffi
    git add --force -A
    git commit -a -m "Libtool 2.4.2 files from libffi-3.2.1.tar.gz"
    AUTOMAKE=/usr/bin/automake-1.13 ACLOCAL=/usr/bin/aclocal-1.13 PATH=/tmp/test/libtool-install/bin:$PATH ./autogen.sh
    rm -rf autom4te.cache fficonfig.h.in~
    git add --force -A
    git commit -a -m "Update to libtool 2.4.6.34"
    git format-patch -4
    mv 0004-Update-to-libtool-2.4.6.34.patch ~/conda-forge/libffi-feedstock/recipe
  popd
popd

