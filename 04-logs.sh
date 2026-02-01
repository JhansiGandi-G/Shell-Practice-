#!/bin/bash

USERID=$(id -u)
LOG_FOLDER = "/var/log/shell-script"
LOGS_FILE = "/var/log/shell-script/$0.log"

if  [ $USERID -ne 0 ]; then
    echo "please run the script from root user" | tee -a $LOGS_FILE
    exit 1
fi

VALIDATE(){

    if [ $1 -ne 0 ]; then
        echo "$2 ... failure" | tee -a $LOGS_FILE 
        exit 1
    else
        echo "$2 .. success" | tee -a $LOGS_FILE
    fi
}

dnf install nginx -y &>> $LOGS_FILE
VALIDATE $? " Installing Nginx"

dnf install mysql -y &>> $LOGS_FILE
VALIDATE $? "Installing mysql"

dnf install nodejs -y &>> $LOGS_FILE
VALIDATE $? "Installing NodeJs"
