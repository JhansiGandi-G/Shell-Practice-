#!/bin/bash

USERID=$(id -u)

if  [ $USERID -ne 0 ]; then
    echo "please run the script from root user"
    exit 1
fi

VALIDATE(){

    if [ $1 -ne 0 ]; then
        echo "$2 ... failure"
        exit 1
    else
        echo "$2 .. success"
    fi
}

dnf install nginx -y
VALIDATE $? " Installing Nginx"

dnf install mysql -y
VALIDATE $? "Installing mysql"

dnf install nodejs -y
VALIDATE $? "Installing NodeJs"
