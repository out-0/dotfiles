#!/bin/bash

# List available SSIDs
SSID=$(nmcli -t -f SSID dev wifi | grep -v '^$' | sort -u | rofi -dmenu -p "Wi-Fi")

# Exit if nothing selected
[ -z "$SSID" ] && exit

# Check if connection already exists
if nmcli connection show | grep -q "^$SSID "; then
    # Use saved connection (won't ask for password)
    nmcli connection up id "$SSID"
else
    # Ask for password for new network
    PASSWORD=$(rofi -dmenu -password -p "Password for $SSID")
    [ -z "$PASSWORD" ] && exit
    nmcli device wifi connect "$SSID" password "$PASSWORD"
fi

