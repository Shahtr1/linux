#!/bin/bash

log() {
	# This function sends a message to syslog and to standard output if VERBOSE iis true.
	local MESSAGE="${@}"
	if [[ "${VERBOSE}" = 'true' ]]
	then
		echo "${MESSAGE}"
	fi
	logger -t luser-demo10.sh "${MESSAGE}"
}

# or 

# function log {
# 	echo 'You called the log function!'
# }

backup_file(){
	# This function createws a backup of a file. Returns non-zero status on error.

	local FILE="${1}"

	# Make sure the file exists.
	if [[ -f "${FILE}" ]]
	then
		local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
		log "Backing up ${FILE} to ${BACKUP_FILE}."

		# The exit status of the function will be the exit status iif the cp command.
		cp -p ${FILE} ${BACKUP_FILE}
	else
		# The file does not exist, so return a non-zero exit status.
		return 1
	fi

}

readonly VERBOSE='true'
log 'Hello!'
log 'This is fun!'

backup_file '/etc/passwd'

# Make a decision based on the exit status of the function.
if [[ "${?}" -eq '0' ]]
then
	log 'File backup succeeded!'
else
	log 'File backup failed!'
	exit 1
fi
