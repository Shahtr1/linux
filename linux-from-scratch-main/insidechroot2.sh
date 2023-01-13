# The login, agetty, and init programs (and others) use a number of log files to record information such as who was logged into the system and when.
# The /var/log/wtmp file records all logins and logouts
# The /var/log/lastlog file records when each user last logged in.
# The /var/log/faillog file records failed login attempts.
# The /var/log/btmp file records the bad login attempts.
# The /run/utmp file records the users that are currently logged in. This file is created dynamically in the boot scripts.
touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp

export LFS=""
cd /sources


# Chapter 7
# for package in gettext bison perl python texinfo util-linux; do
#     source packageinstall.sh 7 $package
# done


