#!/bin/bash
USERID=$(id -u)

if [$USERID ne 0 ]; then
    echo "please run the script from root user"
    exit 1
fi

echo "Installing nginx"

dnf install nginx -y

if [$? -ne 0]; then
    echo " installtion nginx ... failure"
    exit 1
else
    echo " installing nginx .. success"
fi