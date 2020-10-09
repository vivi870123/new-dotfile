#!/bin/bash

# Set path for running in a cron job
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/home/chris/.local/bin'

# Set limit to shell argument
batteryLimit=$1

# Get the current battery level with acpi
batteryLevel=$(acpi | cut -d ' ' -f 4 | tr -d '%|,| ')
charging=$(acpi | cut -d ' ' -f 3 | tr -d ',| ')


if [[ "$batteryLevel" -le "$batteryLimit" ]] && [[ "$charging" == "Discharging" ]]; then
    notify-send -a "Battery Warning" --urgency critical "Battery level at ${batteryLevel}%" -i abrt
fi
