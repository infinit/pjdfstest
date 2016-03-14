#!/bin/sh
# $FreeBSD: head/tools/regression/pjdfstest/tests/rmdir/02.t 211352 2010-08-15 21:24:17Z pjd $

desc="rmdir returns ENAMETOOLONG if a component of a pathname exceeded {NAME_MAX} characters"

dir=`dirname $0`
. ${dir}/../misc.sh

echo "1..3"

nx=`namegen_max`
nxx="${nx}x"

expect 0 mkdir ${nx} 0755
expect 0 rmdir ${nx}
expect ENOENT rmdir ${nx}
# XXX: ENAMETOOLONG
# expect ENAMETOOLONG rmdir ${nxx}
