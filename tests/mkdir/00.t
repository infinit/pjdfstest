#!/bin/sh
# $FreeBSD: head/tools/regression/pjdfstest/tests/mkdir/00.t 211352 2010-08-15 21:24:17Z pjd $

desc="mkdir creates directories"

dir=`dirname $0`
. ${dir}/../misc.sh

echo "1..7"

n0=`namegen`
n1=`namegen`

expect 0 mkdir ${n1} 0700
cdir=`pwd`
cd ${n1}

# POSIX: Upon successful completion, mkdir() shall mark for update the st_atime,
# st_ctime, and st_mtime fields of the directory. Also, the st_ctime and
# st_mtime fields of the directory that contains the new entry shall be marked
# for update.
expect 0 chown . 0 0
time=`${fstest} stat . ctime`
sleep 1
expect 0 mkdir ${n0} 0755
# XXX: atime
# atime=`${fstest} stat ${n0} atime`
# test_check $time -lt $atime
mtime=`${fstest} stat ${n0} mtime`
test_check $time -lt $mtime
ctime=`${fstest} stat ${n0} ctime`
test_check $time -lt $ctime
mtime=`${fstest} stat . mtime`
# XXX: Matthieu
# test_check $time -lt $mtime
ctime=`${fstest} stat . ctime`
# XXX: Matthieu
# test_check $time -lt $ctime
expect 0 rmdir ${n0}

cd ${cdir}
expect 0 rmdir ${n1}
