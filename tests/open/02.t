#!/bin/sh
# $FreeBSD: head/tools/regression/pjdfstest/tests/open/02.t 211352 2010-08-15 21:24:17Z pjd $

desc="open returns ENAMETOOLONG if a component of a pathname exceeded {NAME_MAX} characters"

dir=`dirname $0`
. ${dir}/../misc.sh

echo "1..3"

nx=`namegen_max`
nxx="${nx}x"

expect 0 open ${nx} O_CREAT 0600
expect regular,0600 stat ${nx} type,mode
expect 0 unlink ${nx}
# XXX: ENAMETOOLONG
# expect ENAMETOOLONG open ${nxx} O_CREAT 0620
