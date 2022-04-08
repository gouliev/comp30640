#!/bin/bash

if [ "$#" -ne 1 ] #Conditional IF statement, is less than, e.g. ('$a' -lt '$b')
then #Return:
	echo "Error: no parameter"
	exit 1 #General errors/Miscellaneous errors
fi

if [  ! -d "$1" ] #Comparisons and means NOT, -d implies file is a directory
then #Return:
	mkdir ./$1 #Make directory
	echo "OK: database created"
else
	echo "Error: DB already exists"
	exit 1 #General errors/Miscellaneous errors
fi

exit 0 #Success
