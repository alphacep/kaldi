#!/bin/bash

OPENFST_VERSION=1.7.5

WGET=${WGET:-wget}

set -e

tarball=openfst-$OPENFST_VERSION.tar.gz

rm -rf openfst-* openfst openfst-*.tar.gz

if [ -d "$DOWNLOAD_DIR" ]; then
  cp -p "$DOWNLOAD_DIR/$tarball" .
else
  $WGET -t3 -nv -O $tarball "http://openfst.org/twiki/pub/FST/FstDownload/${tarball}"
fi

tar xzf $tarball
mv openfst-$OPENFST_VERSION openfst

cd openfst
./configure --prefix=$(pwd) --enable-static --enable-shared --enable-far --enable-ngram-fsts
make -j $(grep -c '^processor' /proc/cpuinfo 2>/dev/null) all install
cd ..
