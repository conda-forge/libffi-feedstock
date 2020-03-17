#!/usr/bin/env bash

set -e -x

mkdir build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DVERSION=$PKG_VERSION \
    ..
cmake --build . --config Release -- -j${CPU_COUNT}
cmake --build . --target install --config Release
