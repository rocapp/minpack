#!/usr/bin/env bash

export CC=gcc

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
echo -e "$(pkg-config --modversion minpack)"

# site packages
export MINPACK_SITE=${MINPACK_SITE:-$(python3 -c $'import sys; print(sys.path[-1])')}
# python version
PYTHON_VERSION=$(type python3)
# repo root directory
MINPACK_DIR=${MINPACK_DIR:-$(pwd)}

# Build minpack
cd ${MINPACK_DIR} || exit
fpm build
sleep 1s
meson setup --reconfigure _build -Dpython_version=${PYTHON_VERSION} || exit
sleep 1s

# Install minpack
meson install -C _build || exit
sleep 1s

# Install minpack python extension
cd ${MINPACK_DIR}/python || exit
python3 -m pip install --upgrade cffi
meson setup --wipe --reconfigure _build -Dpython_version=${PYTHON_VERSION} || exit
meson compile -C _build || exit
meson configure _build --prefix=$MINPACK_SITE || exit
meson install -C _build || exit

# Test minpack python extension
cd ~ && python3 -c $'import minpack\nprint(dir(minpack))'
cd - || exit
echo "...done install minpack python extension."
