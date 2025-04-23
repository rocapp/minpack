#!/usr/bin/env bash

export PYTHON_VERSION=$(which python3)

echo 'setup...'
meson setup --wipe _build
echo '...done setup.'

echo 'configure...'
meson --reconfigure -Dpython_version=${PYTHON_VERSION} -Dpython=true --prefix=~/.local _build
echo '...done configure.'

echo 'install...'
meson install -C _build
echo '...done install.'

# Test minpack python extension
cd ./python && $PYTHON_VERSION -m build && cd - && \
    cd ./python && $PYTHON_VERSION setup.py install --prefix ~/.local
cd ~ && python3 -c $'import minpack\nprint(dir(minpack))'
cd - || exit
echo "...done install minpack python extension."
