#! /bin/bash
	clear
	if [ "$(whoami)" != "root" ]
	then
		sudo su -s "$0"
	echo "You have now signed in"

	#if [sudo modprobe pcspkr]
	#then
	#echo -e '\a' > /dev/console
	fi


