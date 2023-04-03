#!/bin/bash
# falsetone.sh - 2023-04-03 Sebastian Simmons
# Disables TrueTone on Macs with ambient light sensors.
# TrueTone affects the color temperature of the display based on the ambient light.
# This script disables TrueTone, which is important for color-critical work.
# Script requires root privileges.

coreBrightness="/private/var/root/Library/Preferences/com.apple.CoreBrightness.plist"

# Get current logged in user
currentUser=$(echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }')

currentUserUID=$(dscl . -read /Users/$currentUser/ GeneratedUID) # Get the GeneratedUID for the current user
currentUserUID=$(echo $currentUserUID | cut -d' ' -f2)           # Remove the "GeneratedUID: " part
currentUserUID="CBUser-"$currentUserUID                          # Append the prefix

echo "Disabling TrueTone for ${currentUser}..."

/usr/libexec/PlistBuddy -c "Set :${currentUserUID}:CBColorAdaptationEnabled 0" $coreBrightness

echo "CBColorAdaptationEnabled for $currentUserUID set to 0."

# Kill cfprefsd and corebrightnessd to apply changes
echo "Killing cfprefsd and corebrightnessd..."
sudo killall cfprefsd
sudo killall corebrightnessd

exit 0
