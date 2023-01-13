#!/bin/bash

# This script generates a random password for each user specified on the command line.

# Display what the user typed on the command line.
# A parameter is a variable used in the shell script
# Argument is the data passed
echo "You executed this command: ${0}"

# Display the oath and filename of the script.
echo "You used $(dirname ${0}) as the path to the $(basename ${0}) script."


# Tell them how many argument(s) they passed in.
NUMBER_OF_PARAMETERS="${#}"
echo "you supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line."


# Make sure they at least supply one argument.
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [USER_NAME]..."
	exit 1
fi

# Generate and display a password for each parameter.
# ${*} treats everything as one argument
# ${@} treats everything as separate argument separated by space
for USER_NAME in "${@}"
do
	PASSWORD=$(date +%s%N | sha256sum | head -c48)
	echo "${USER_NAME}: ${PASSWORD}"
done

