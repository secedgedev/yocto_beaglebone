#!/bin/bash
#
#

echo "Initalizing repo for langdale"

TOPDIR=$(pwd)

git clone git://git.yoctoproject.org/poky
cd poky
git checkout 744cea3bfeebcde151499a424fea6bf98d226c9b

echo "applying patches"
for j in `ls $TOPDIR/patches/*`
do
    patch -p1 < $j
done

source oe-init-build-env

bitbake-layers layerindex-fetch meta-oe
bitbake-layers layerindex-fetch meta-networking
bitbake-layers layerindex-fetch meta-filesystems

cp $TOPDIR/local.conf ./conf/

bitbake core-image-full-cmdline


