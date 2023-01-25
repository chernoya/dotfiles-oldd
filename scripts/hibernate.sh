#!/bin/sh

acpi -b | grep "Battery 0" | awk -F'[,:%]' '{print $2, $3}' | {
	read -r status capacity

	if [ "$status" = Discharging -a "$capacity" -lt 15 ]; then
		logger "Critical battery threshold"
		~/.config/scripts/lock.sh
		logger "Locked system"
		systemctl hibernate
	fi
}
