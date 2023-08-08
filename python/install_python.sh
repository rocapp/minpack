#!/bin/sh

export CC=gcc

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
echo -e "$(pkg-config --modversion minpack)"
pyenv shell 3.10.9

export MINPACK_SITE=$(pyenv prefix)/lib/python3.10/site-packages/minpack
meson setup _build -Dpython_version=$(which python3) || exit
meson compile -C _build || exit 
meson configure _build --prefix=$MINPACK_SITE || exit
meson install -C _build || exit

cd ~ && python -c $'import minpack\nprint(dir(minpack))'

cd -
echo "...done."
