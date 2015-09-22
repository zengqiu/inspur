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
    echo "Begin backup DB2 database."

    db2 backup db ecgap online to /backup/beifen/ecgap include logs >> /backup/beifen/ecgap/ecgap_backup.log;
    if [ $? -eq 0 ]; then
        find /backup/beifen/ecgap -ctime +14 -exec rm -rf {} \;
        find /db2log/db2inst1/ECGAP/NODE0000/C0000000 -ctime +14 -exec rm -rf {} \;
    else
        echo "Backup ecgap not complete!" >> /backup/beifen/ecgap/ecgap_backup.log;
    fi

    db2 backup db ecgapout online to /backup/beifen/ecgapout include logs >> /backup/beifen/ecgapout/ecgapout_backup.log;
    if [ $? -eq 0 ]; then
        find /backup/beifen/ecgapout -ctime +14 -exec rm -rf {} \;
        find /db2log/db2inst1/ECGAPOUT/NODE0000/C0000000 -ctime +14 -exec rm -rf {} \;
    else
        echo "Backup ecgapout not complete!" >> /backup/beifen/ecgapout/ecgapout_backup.log;
    fi

    db2 backup db emonitor online to /backup/beifen/emonitor include logs >> /backup/beifen/emonitor/emonitor_backup.log;
    if [ $? -eq 0 ]; then
        find /backup/beifen/emonitor -ctime +14 -exec rm -rf {} \;
        find /db2log/db2inst1/EMONITOR/NODE0000/C0000000 -ctime +14 -exec rm -rf {} \;
    else
        echo "Backup emonitor not complete!" >> /backup/beifen/emonitor/emonitor_backup.log;
    fi

    db2 backup db middle online to /backup/beifen/middle include logs >> /backup/beifen/middle/middle_backup.log;
    if [ $? -eq 0 ]; then
        find /backup/beifen/middle -ctime +14 -exec rm -rf {} \;
        find /db2log/db2inst1/MIDDLE/NODE0000/C0000000 -ctime +14 -exec rm -rf {} \;
    else
        echo "Backup middle not complete!" >> /backup/beifen/middle/middle_backup.log;
    fi

    db2 backup db perform online to /backup/beifen/perform include logs >> /backup/beifen/perform/perform_backup.log;
    if [ $? -eq 0 ]; then
        find /backup/beifen/perform -ctime +14 -exec rm -rf {} \;
        find /db2log/db2inst1/PERFORM/NODE0000/C0000000 -ctime +14 -exec rm -rf {} \;
    else
        echo "Backup perform not complete!" >> /backup/beifen/perform/perform_backup.log;
    fi
fi