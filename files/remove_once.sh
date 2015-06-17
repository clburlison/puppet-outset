#!/bin/sh

for USER_HOME in /Users/*
do
	USER_UID=`basename "${USER_HOME}"`
	if [ ! "${USER_UID}" = "Shared" ]
	then
		if [ -d "${USER_HOME}"/Library/Preferences ]
		then
			/usr/bin/su "${USER_UID}"
			/usr/bin/defaults delete "${USER_HOME}"/Library/Preferences/com.github.outset.once.plist /usr/local/outset/login-once/$1
			/usr/bin/plutil -convert xml1 "${USER_HOME}"/Library/Preferences/com.github.outset.once.plist
			/usr/sbin/chown "${USER_UID}":admin "${USER_HOME}"/Library/Preferences/com.github.outset.once.plist
		fi
	fi
done

exit 0