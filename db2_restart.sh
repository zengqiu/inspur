#!/bin/bash
#author: zengqiu

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /db2data/db2inst1/sqllib/db2profile ]; then
    . /db2data/db2inst1/sqllib/db2profile
fi

db2 force application all
db2stop force
db2start