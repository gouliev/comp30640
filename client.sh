#!/bin/bash

if [ "$#" -ne 1 ] #Set parameter before entering body
then
        echo "Error: no parameter"
        exit 1 #General errors/Miscellaneous errors
fi

#Creating pipe variables wikipedia named pipes
server_pipe=/tmp/server.pipe #Server pipe
client_pipe=/tmp/$1.pipe #Client pipe parameter 1.pipe

trap ctrl_c INT
#Function for ctrl_c with message we are cleaning pipes
function ctrl_c() { #^C
	echo " Cleaning pipes..."
	rm -f $client_pipe #Remove file
	exit 0
}


if [[ ! -p $client_pipe ]];then #Conditional if
        mkfifo $client_pipe #FIFO file with name, makes a special file with the path name
else
	echo "Client already exists" #Print message to if duplicate
	echo "Exiting..." #Notify we are exiting
	exit 1 #General errors/Miscellaneous errors
fi


if [[ ! -p $server_pipe ]];then #If the server pipe does not exist, print error message
	echo "Server is down"
	rm -f $client_pipe #Remove the client pipe with exit 1
	exit 1 #General errors/Miscellaneous errors
fi
#Communicating - server receiving command from the client
#Similar to our server.sh see comments for explaination
while true; do #While loop (conditional)
read -p "" command 
IFS=' ' read -r -a command_list <<< $command #Creates the command into an array from a string
case "${command_list[0]}" in
        create_database) #Creates database
		echo "${command_list[0]}" "$1" "${command_list[1]}"
		#This is where we use pipe
		echo "$command" >$server_pipe
		echo "testing" >$server_pipe
                ;;
        create_table) #Prints out the command
 		echo "${command_list[0]}" "$1" "${command_list[1]}"  "${command_list[2]}" "${command_list[3]}"
                echo $command >$server_pipe #Sends command to server through the pipe
                ;;
        insert)
		echo "${command_list[0]}" "$1" "${command_list[1]}"  "${command_list[2]}" "${command_list[3]}"
		echo $command >$server_pipe #Sends command to server through the pipe
		;;
	select)
		echo "${command_list[0]}" "$1" "${command_list[1]}"  "${command_list[2]}" "${command_list[3]}"
		echo $command >$server_pipe #Sends command to server through the pipe
                ;;
        exit)
		echo "${command_list[0]}" "$1"
                echo "Client $1 Exiting..."
		ctrl_c #^C
                ;;
        *)
                echo "Error: bad request"
                exit 1 #General errors/Miscellaneous errors
esac
done
