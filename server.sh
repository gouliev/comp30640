#!/bin/bash

server_pipe=/tmp/server.pipe #We define where the server pipe is
#client_pipe=/tmp/
trap ctrl_c INT
#Function for ctrl_c with message we are cleaning pipes
function ctrl_c() { #^C
        echo "Cleaning pipes..."
        rm -f $server_pipe #Remove -f
        exit 0 #Success
}



if [[ ! -p $server_pipe ]]; then
	mkfifo $server_pipe #Creates a FIFO aka named pipe, pointed by a path
fi

while true; do #While statement (loop)

read command <$server_pipe #Communicating - server receiving command from the client
IFS=' ' read -r -a command_list <<< $command #Creates the command into an array from a string
case "${command_list[0]}" in #Index [0]
	create_database)
		./create_database.sh "${command_list[1]}" #Running ./create_database
#		echo "OK:">$client_pipe
		;;
	create_table) #Executing the create_table sh script
		./create_table.sh "${command_list[1]}" "${command_list[2]}" "${command_list[3]}"
		;;
	insert) #Executing the insert sh script
		./insert.sh  "${command_list[1]}" "${command_list[2]}" "${command_list[3]}"
		;;
	select) #Executing the select sh script
		./select.sh  "${command_list[1]}" "${command_list[2]}" "${command_list[3]}"
		;;
	shutdown) #Shutting down ^O
		echo "Shutting down..."
		ctrl_l #Shuts down the server
		;;
	*)
		echo "Error: bad request"
		read line <$server_pipe #Incase the server puts a bad request, we notify them
		echo line
		exit 1 #General errors/Miscellaneous errors
esac
done
