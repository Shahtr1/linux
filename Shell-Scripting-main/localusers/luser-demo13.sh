#!/bin/bash

# This script shows the open network ports on a system.
# Use -4 as an argument to limit to tcpv4 ports

netstat -nutl ${1} | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}'

# also you can use p option to get the service name like, but with sudo privileges
# sudo netstat -nutlp | grep 22