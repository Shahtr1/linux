#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then
	echo "[-] You have to be a superuser(root) to run this script."
	exit 1
fi

read -p 'Enter new username: ' USER_NAME
read -p 'Enter full name: ' FULL_NAME
read -p 'Enter password: ' PASSWORD

useradd -c "${FULL_NAME}" -m ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
	echo "[-] Error while creating the user account, process exited with status code ${?}."
	exit 1
fi

echo "${PASSWORD}" | passwd --stdin ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
	echo "[-] Error while setting the password for user ${USER_NAME}."
	exit 1
fi

passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created
echo
echo 'username: '
echo "${USER_NAME}"
echo
echo 'password: '
echo "${PASSWORD}"
echo
echo "host: "
echo "${HOSTNAME}"

