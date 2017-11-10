#!/usr/bin/env bash
set -ex

if [[ $(uname) == "Linux" ]]; then
  # this changes the install dir from ${PREFIX}/lib64 to ${PREFIX}/lib
  sed -i 's:@toolexeclibdir@:$(libdir):g' Makefile.in */Makefile.in
  sed -i 's:@toolexeclibdir@:${libdir}:g' libffi.pc.in
fi
if [[ $(uname -o) == "Msys" ]]; then
  ./configure --prefix="${PREFIX}" \
			  --includedir="${PREFIX}/include" \
              --disable-debug \
			  --disable-dependency-tracking \
              --build=x86_64-w64-mingw32 \
              --enable-static \
			  --disable-shared
else
  ./configure --disable-debug --disable-dependency-tracking \
              --prefix="${PREFIX}" --includedir="${PREFIX}/include" 
fi
make
make check
make install
