#!/bin/bash
#author: zengqiu

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f /root/.bashrc ]; then
    . /root/.bashrc
fi

TONGWEB_PATH=`locate startnohup.sh | grep -e 'startnohup.sh$' | awk -F"/" '{i = 2; while(i < NF - 1){printf "/%s", $i; i++}}'`

function tongweb_stop
{
    echo "##### Begin to stop TongWeb #####"
    
    kill -9 `ps aux | grep -v grep | grep java | awk '{printf "%s ", $2}'`
    
    echo "##### Stop TongWeb finished #####"
}

function tongweb_start
{
    echo "##### Begin to start TongWeb #####"
    
    rm -rf $TONGWEB_PATH/work/
    
    cd $TONGWEB_PATH/bin/
    ./startnohup.sh > /dev/null
    #nohup ./tongserver.sh & > /dev/null
    
    echo "##### Start TongWeb finished #####"
}

tongweb_stop
tongweb_start