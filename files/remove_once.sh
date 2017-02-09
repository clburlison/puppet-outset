#!/bin/sh

for USER_HOME in /Users/*
do
	USER_UID=`basename "${USER_HOME}"`
	if [ ! "${USER_UID}" = "Shared" ]
	then
		if [ -d "${USER_HOME}"/Library/Preferences ]
		then
			/usr/bin/sudo -s -u "${USER_UID}" /usr/bin/defaults delete /Users/"${USER_HOME}"/Library/Preferences/com.github.outset.once /usr/local/outset/login-once/$1
		fi
	fi
done

exit 0
