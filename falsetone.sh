#!/bin/bash
# falsetone.sh
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

# Check if com.apple.CoreBrightness.plist exists
if test -f "$coreBrightness"; then
    echo "Disabling TrueTone for ${currentUser}..."

    /usr/libexec/PlistBuddy -c "Set :${currentUserUID}:CBColorAdaptationEnabled 0" $coreBrightness

    echo "CBColorAdaptationEnabled for $currentUserUID set to 0."

    # Kill cfprefsd and corebrightnessd to apply changes
    echo "Killing cfprefsd and corebrightnessd..."
    sudo killall cfprefsd
    sudo killall corebrightnessd
else
    echo "$coreBrightness does not exist."
    echo "System does not have an ambient light sensor and therefore has no TrueTone setting."
    echo "Exiting..."
    exit 2
fi


exit 0
