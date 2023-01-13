#!/bin/bash

# This script demonstrates I/O redirection.

# Redirect STDOUT to a file.
FILE="/tmp/data"
head -n2 /etc/passwd > ${FILE}

# Redirect STDIN to a program.
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

# redirect STDOUT to a file, overwriting the file
head -n2 /etc/passwd > ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# redirect STDOUT to a file, appending to the file.
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo 
echo "Contents of ${FILE}:"
cat ${FILE}


# by default every new process starts with 3 file descriptors
# file decriptors is a way that a program interacts with a file through other resources that work like a file.
#
# FD 0 -STDIN
# FD 1 -STDOUT
# FD 2 -STDERR

# send both stdout and stderr to one file
# head -n1 /etc/passwd /etc/hosts /fakefile > head.both 2>&1 # &1 sends it to the field descriptor FD 1
# head -n1 /etc/passwd /etc/hosts /fakefile &> head.both # new way
# head -n1 /etc/passwd /etc/hosts /fakefile &>> head.both # appends

# cat command only receives the stdout if you pass output to cat like        | cat   
# to make cat get err too, just do       2>&1 | cat         and for numbers do       2>&1 | cat -n 
# or by new way 
# head -n1 /etc/passwd /etc/hosts /fakefile |& cat -n

# Redirect STDIN to a program, using FD 0
read LINE 0< ${FILE}
echo
echo "LINE contains: ${LINE}"

# redirect STDOUT to a file using FD 1, overwriting the file.
head -n3 /etc/passwd 1> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# redirecting STDERR to a file using FD 2.
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}

# redirect STDOUT and STDERR to a file
head -n3 /etc/passwd /fakefile &> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# redirect STDOUT and STDERR through a pipe.
echo
head -n3 /etc/passwd /fakefile |& cat -n

# echo 'error' >&2 | cat -n # output never gets to cat, thats is why no line number
# # the above can also be written as
# echo 'error' 1>&2 | cat -n

# Send output to STDERR
echo "This is STDERR!" >&2

# Discard STDOUT
echo 
echo "Discarding STDOUT:"
head -n3 /etc/passwd /fakefile > /dev/null

# Discard STDERR
echo 
echo "Discarding STDERR:"
head -n3 /etc/passwd /fakefile 2> /dev/null

# Discard STDOUT and STDERR
echo 
echo "Discarding STDOUT and STDERR:"
head -n3 /etc/passwd /fakefile &> /dev/null

# Clean up
rm ${FILE} ${ERR_FILE} &> /dev/null














