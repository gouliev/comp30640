#!/bin/bash

FILE="./$1/$2" #Assign variable FILE to ./$1/$2 (these are positional parameters)
if [ "$#" -ne 3 ];then #If parameter not equals to 3, then return:
        echo "Error: parameters problem"
        exit 1
elif [ ! -d "$1" ]; then #Else IF NOT directory THEN return:
        echo "Error: DB does not exist"
        exit 1
elif [ ! -f "$FILE" ]; then #Else IF NOT THEN return:

        echo "Error: table does not exist"
        exit 1
else
        head=$(head -n 1 $FILE) #The -n string operator for evaluating expression, true if non-empty
        commas="${head//[^,]}" #Regular exrpressions, metacharacters, REGEX
#https://medium.com/introduction-into-bash/bash-scripts-regular-expressions-7d1a0473a902 {tutorial}
        number_cols=$((${#commas} + 1)) #+1 because we are seperating words, e.g "ok,ok,ok"
	IFS=',' read -r -a col_range <<< "$3" #internal field separator, delimiters, splot a line of input
	if if [ $number_cols -lt ${col_range[0]} ] || [ $number_cols -lt ${col_range[1]} ];then #If num of cols less than the range of cols
		echo "Error: column does not exist" #Return error
		exit 1
	else
		echo "start_result" #Start result
		while IFS= read -r line #File has read permission (for the user running the test)
		do
			IFS=',' read -r -a cells <<< "$line"
			for i in {0..2} #For var in range of {start int to end int}
			do
				echo -n "${cells[$i]}" #Index cell [index]
				if [ $i -ne ${col_range[1]} ];then
					echo -n ","
				fi
			done
			echo ""
		done< "$FILE" #overwrites (also known as STDOUT (default file processor to write output)
		echo "end_result" #End result
        fi
fi

exit 0 #Success

