#!/bin/bash
#author: zengqiu

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f /db2data/db2inst1/sqllib/db2profile ]; then
    . /db2data/db2inst1/sqllib/db2profile
fi

ret=`df -h | grep '/db2data$'`
if [ "x$ret" = "x" ]; then
    echo "DB2 is not running on the current machine."
else
    echo "Begin clean DB2 database."

    db2 connect to ecgap
    LOG=`db2 get db cfg for ecgap | grep 'First active log file' | awk -F '=' '{print $2}' | tr -d ' '`
    db2 prune logfile prior to $LOG;

    if [ $? -eq 0 ]; then
        find /db2log/db2inst1/ECGAP/NODE0000/C0000000 -ctime +1 -exec rm -rf {} \;
        echo "Clean ecgap complete!"
    else
        echo "Clean ecgap not failed!"
    fi
fi