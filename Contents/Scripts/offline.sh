#!/bin/sh

osascript -e "tell application \"Adium\" to account id ${1} go offline"
osascript -e "tell application \"LaunchBar\" to hide"
