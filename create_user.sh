#!/bin/bash

source include/sh-lib

# check to run the script as root
if ! check_root; then
    error_msg "Please run the script as root"
fi

