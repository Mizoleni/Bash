#!/bin/bash

#Cleanup version 3

LOG_DIR=/var/log
ROOT_UID=0 	#users wth $UID have acess to root privilages
LINES=50	#Number of lines saved by default.
E_XCD=86	#Unable to change directory?
E_NOTROOT=87	#Non-root exit error.

#This program should be run as root
if [ "$UID" -ne "$ROOT_UID" ]
then
	echo "Hey, you gotta be root to run this script."
	exit $E_NOTROOT
fi

if [ -n "$1" ]
# Testing if a command-line argument is present (non-empty).
then
	lines=$1
else
	lines=$LINES 

#Default, if not specified on command-line

fi

## An alternative way to checking the command-line arguments

#	E_WRONGARGS=85 	#Non-numerical argument (bad arg format).

#	case "$1" in
#	""	) lines=50;;
#	*[!0-9]*) echo "Usage: `basename $0` lines-to-cleanup";
#	exit $E_WRONGARGS;;
#	*	) lines=$1;;
#	esac
# This is to do with loops

cd $LOG_DIR
	if [ `pwd` != "$LOG_DIR" ] #or if [ "$PWD" != "$LOG_DIR" ]
				   # If it's not in /var/log
then
	echo "Can't change to $LOG_DIR."
	exit $E_XCD
fi	#Makes sure it's in the right directory before messing with the log files

#	Another efficient way is:
#
#	cd /var/log || {
#	echo "Cannot chaange to the named directory.">&2
#	exit $E_XCD;
#}

tail -n $lines messages > mesg.temp # Save last section of message log file.
mv mesg.temp messages 		    # Rename it as system log file.

cat /dev/null > wtmp
echo "Log files cleaned up."

exit 0

