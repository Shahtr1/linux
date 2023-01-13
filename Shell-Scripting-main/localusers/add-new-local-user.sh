#!/bin/bash


# This script creates a new user on the local system.
# You must supply a username as an argument to the script
# Optionally you can also provide a comment for the account as an argument
# A password will be automatically generated for the account
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
	echo '[-] You are not root.'
	exit 1
fi

# If they dont supply at least one argument, the give them help.
if [[ "${#}" -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [COMMENT]..."
	echo 'Create an account on the local system with the name USER_NAME and a comments field of COMMENT'
	exit 1
fi

# The first parameter is the user name
USER_NAME="${1}"

# The rest of teh parameters are for the account comments.
shift # making everything else drop off
COMMENT="${@}" # assigning comment to everything else using @

# Generate a password
PASSWORD=$(date +%s%N | sha256sum | head -c48)

# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check for the return status
if [[ "${?}" -ne 0 ]]
then
	echo 'The account could not be created.'
	exit 1
fi

# Set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if teh password command succeeded.
if [[ "${?}" -ne 0 ]]
then
	echo 'The password for the account could not be set.'
	exit 1
fi

# Force password change
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo 
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"



