#!/bin/bash

TCP_STATE='{"TCP_STATE":{"ESTABLISHED":0,"SYN_SENT":0,"SYN_RECV":0,"FIN_WAIT1":0,"FIN_WAIT2":0,"TIME_WAIT":0,"CLOSE":0,"CLOSE_WAIT":0,"LAST_ACK":0,"LISTEN":0,"CLOSING":0}}'

function replace_state() {
    echo $* | sed \
        -e "s#ESTAB#ESTABLISHED#g" \
        -e "s#SYN-SENT#SYN_SENT#g" \
        -e "s#SYN-RECV#SYN_RECV#g" \
        -e "s#FIN-WAIT-1#FIN_WAIT1#g" \
        -e "s#FIN-WAIT-2#FIN_WAIT2#g" \
        -e "s#TIME-WAIT#TIME_WAIT#g" \
        -e "s#UNCONN#CLOSE#g" \
        -e "s#CLOSE-WAIT#CLOSE_WAIT#g" \
        -e "s#LAST-ACK#LAST_ACK#g"
    #-e "s#LISTEN#LISTEN#g" \
    #-e "s#CLOSING#CLOSING#g"
}

replace_state $(ss -antH | awk '{++S[$1]}END{for (s in S) print s":"S[s]}') | tr ' ' '\n' |
    while read line; do
        state=$(echo $line | awk -F ':' '{print $1}')
        count=$(echo $line | awk -F ':' '{print $2}')
        TCP_STATE=$(echo $TCP_STATE | sed "s#\"$state\":0#\"$state\":$count#g")
        echo $TCP_STATE
    done |
    tail -n 1
