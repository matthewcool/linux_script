#!/bin/bash

source include/sh-lib

#check to run the script as root
if ! check_root; then
    error_msg "Please run the script as root!"
fi

#check args and print usage
if [ $# -lt 1 ]; then
    echo "Usage: $0 [user_name]..."
fi

for user_name in $@
do
    grep "^$user_name:" /etc/passwd > /dev/null
    if [ $? -eq 0 ]; then
        echo "The user '$user_name' already exists!"
        exit 1
    else
        #default password is user's name
        passwd=$(perl -e 'print crypt($ARGV[0], "password")' $user_name)
        useradd -m -p $passwd $user_name -s /bin/bash
        [ $? -eq 0 ] && echo "The user '$user_name' has been added to system!" || echo "Failed to add the user '$user_name' to system!"
    fi
done
