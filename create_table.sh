#!/bin/bash
if [ "$#" -lt 3 ] || [ "$#" -gt 3 ]; #IF conditional less than -lt OR (||) greater than -gt
then #Return:
	echo "Error: parameters problem"
	exit 1 #General errors/Miscellaneous errors
fi

if [ ! -d "$1" ]; then #Return:
	echo "Error: DB does not exist"
	exit 1 #General errors/Miscellaneous errors
fi

if [ -f "./$1/$2" ]; then #File is a regular file (not a directory or device file)

	echo "Error: table already exist"
	exit 1 #General errors/Miscellaneous errors
else
	touch ./$1/$2 #Create the file
	echo "$3" > ./$1/$2
	echo "OK: table created"
fi

exit 0 #Success
