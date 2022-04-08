#!/bin/bash

FILE="./$1/$2" #Assign variable FILE to ./$1/$2 (these are positional parameters)
if [ "$#" -lt 3 ] || [ "$#" -gt 3 ]; #Same as previous script, creating IF 2x OR conditional
then #Returning:
        echo "Error: parameters problem"
        exit 1 #General errors/Miscellaneous errors
elif [ ! -d "$1" ]; then #NOT directory then returning:
        echo "Error: DB does not exist"
        exit 1 #General errors/Miscellaneous errors
elif [ ! -f "$FILE" ]; then #NOT file then returning:

        echo "Error: table does not exist"
        exit 1 #General errors/Miscellaneous errors
else #Assinging variables
	head=$(head -n 1 $FILE) #The -n string operator for evaluating expression, true if non-empty
	commas="${head//[^,]}" #Regular expressions (REGEX)
#https://medium.com/introduction-into-bash/bash-scripts-regular-expressions-7d1a0473a902
	number_commas=${#commas}

	commas_third_argument="${3//[^,]}" #The third argument assigned
	number_commas_third_argument=${#commas_third_argument}

	if [ $number_commas -ne $number_commas_third_argument ];then #Check if not equal and then return:
		echo "Error: number of columns in tuple does not match schema"
		exit 1 #General errors/Miscellaneous errors
	else
		echo "$3" >> $FILE #The >> appends to a file or creates the file if it doesn't exist
		echo "OK: tuple inserted"
	fi
fi

exit 0 #Success

