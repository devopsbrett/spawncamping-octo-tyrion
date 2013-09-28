#!/bin/bash
BASEDIR=$(dirname $(readlink -f $0))
BINDIR=/usr/local/bin
chmod a+x ${BASEDIR}/*
for F in $(ls $BASEDIR)
do
	BINLINK=${BINDIR}/${F%.*}
	[ -f $BINLINK ] || ln -s ${BASEDIR}/${F} ${BINLINK}
done