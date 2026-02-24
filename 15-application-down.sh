#!/bin/bash

NODE_IP="172.31.10.20"
LOG_FILE="/var/log/node-monitor.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if ping -c 2 $NODE_IP > /dev/null 2>&1
then
    echo "$TIMESTAMP : Node $NODE_IP is UP" >> $LOG_FILE
else
    echo "$TIMESTAMP : 🚨 Node $NODE_IP is DOWN" >> $LOG_FILE
fi