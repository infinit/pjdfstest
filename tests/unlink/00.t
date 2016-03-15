#!/bin/sh
# $FreeBSD: head/tools/regression/pjdfstest/tests/unlink/00.t 211352 2010-08-15 21:24:17Z pjd $

desc="unlink removes regular files, symbolic links, fifos and sockets"

dir=`dirname $0`
. ${dir}/../misc.sh

echo "1..17"

n0=`namegen`
n1=`namegen`
n2=`namegen`

expect 0 mkdir ${n2} 0755
cdir=`pwd`
cd ${n2}

# XXX: fifo
# XXX: block
# XXX: char
# XXX: socket
for type in regular symlink; do # fifo block char socket
    create_file ${type} ${n0}
    expect ${type} lstat ${n0} type
    expect 0 unlink ${n0}
    expect ENOENT lstat ${n0} type
done

# successful link(2) updates ctime.
for type in regular symlink; do # fifo block char socket
    create_file ${type} ${n0}
    expect 0 link ${n0} ${n1}
    ctime1=`${fstest} lstat ${n0} ctime`
    sleep 1
    expect 0 unlink ${n1}
    ctime2=`${fstest} lstat ${n0} ctime`
    # XXX: Matthieu.
    # test_check $ctime1 -lt $ctime2
    expect 0 unlink ${n0}
done

# unsuccessful unlink(2) does not update ctime.
# for type in regular symlink; do # fifo block char socket
#     create_file ${type} ${n0}
#     ctime1=`${fstest} stat ${n0} ctime`
#     sleep 1
#     expect EACCES -u 65534 unlink ${n0}
#     ctime2=`${fstest} stat ${n0} ctime`
#     test_check $ctime1 -eq $ctime2
#     expect 0 unlink ${n0}
# done
