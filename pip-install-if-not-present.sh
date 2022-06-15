#!/bin/bash
# $1 : name of a python package
pip list | grep $1
if [ $? ] 
then # 
    echo "Installing package $1 ..."
    pip install $1
else
    echo "Package $1 is already present."
fi
