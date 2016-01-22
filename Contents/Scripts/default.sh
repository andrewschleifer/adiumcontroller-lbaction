#!/bin/bash


echo '['

osascript -e "tell application \"Adium\" to get the id of every account whose status type is offline" | \
    sed 's/, /\'$'\n/g' | \
    while read ID; do
        printf "tell application \"Adium\" to return (name, id, service) of account id $ID" | \
        osascript | \
        sed '
            s|^|{ "title": "|;
            s|, service |", "subtitle": "Connect to |;
            s|, |", "actionArgument": "|;
            s|$|", "action": "online.sh", "icon": "Asleep" },|
        '
    done

osascript -e "tell application \"Adium\" to get the id of every account whose status type is not offline" | \
    sed 's/, /\'$'\n/g' | \
    while read ID; do
        printf "tell application \"Adium\" to return (name, id, service) of account id $ID" | \
            osascript | \
            sed '
                s|^|{ "title": "|;
                s|, service |", "subtitle": "Disconnect from |;
                s|, |", "actionArgument": "|;
                s|$|", "action": "offline.sh", "icon": "com.adiumX.adiumX" },|
            '
    done

echo ']'
