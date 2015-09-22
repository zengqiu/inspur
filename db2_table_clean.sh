#!/bin/bash
#author: zengqiu

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /db2data/db2inst1/sqllib/db2profile ]; then
    . /db2data/db2inst1/sqllib/db2profile
fi

if [ -e /db2data/db2inst1/null ]; then
    rm -rf /db2data/db2inst1/null
    touch /db2data/db2inst1/null
fi

db2 connect to ecgap
db2 "import from /db2data/db2inst1/null of del replace into ecgap.ecgap_ws_log"
db2 reorg table ecgap.ecgap_ws_log
db2pd -d ecgap -tablespaces
db2 "alter tablespace USERSPACE1 reduce max"
db2 "alter tablespace USERSPACE1 lower high water mark"