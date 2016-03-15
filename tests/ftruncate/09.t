#!/bin/sh
# $FreeBSD: head/tools/regression/pjdfstest/tests/ftruncate/09.t 211352 2010-08-15 21:24:17Z pjd $

desc="ftruncate returns EISDIR if the named file is a directory"

dir=`dirname $0`
. ${dir}/../misc.sh

echo "1..3"

n0=`namegen`

expect 0 mkdir ${n0} 0755
expect EISDIR open ${n0} O_RDWR : ftruncate 0 123
expect 0 rmdir ${n0}
