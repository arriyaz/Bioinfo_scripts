#!/bin/bash



while true
do
	read -p "1:Show disk usage. 2: Show uptime. " CHOICE
	case "$CHOICE" in
		1)
			df -h
			break
			;;
		2)
			uptime
			break
			;;
		*)
			echo "Please insert '1' or '2'"
			break
			;;
	esac
done
