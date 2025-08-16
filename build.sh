#!/bin/bash

sh autogen.sh

TOOLCHAIN_PREFIX="/opt/gcc-13.2.0-loongarch64-linux-gnu/bin/loongarch64-linux-gnu"

INSTALL_DIR="${PWD}/loongarch64-build"

CFLAGS="-static -O2"
LDFLAGS="-static"
CONFIGURE_OPTS="--host=${TOOLCHAIN_PREFIX} --enable-static --disable-shared"

echo "Building libevent..."
cd "${LIBEVENT_DIR}"

./configure ${CONFIGURE_OPTS} \
    --host=loongarch64-linux-gnu \
    --prefix="${INSTALL_DIR}" \
    CC="${TOOLCHAIN_PREFIX}-gcc" \
    CXX="${TOOLCHAIN_PREFIX}-g++" \
    AR="${TOOLCHAIN_PREFIX}-ar" \
    RANLIB="${TOOLCHAIN_PREFIX}-ranlib" \
    STRIP="${TOOLCHAIN_PREFIX}-strip" \
    CFLAGS="${CFLAGS}" \
    LDFLAGS="${LDFLAGS}"

make -j$(nproc)
make install