# Script to Disable TrueTone on MacOS for All Users - falsetone.sh
A bash script for disabling TrueTone on MacOS for the current logged in user.

[TrueTone](https://support.apple.com/en-us/HT208909) is a MacOS feature that adjusts the white point and color output of all displays on MacOS systems with Retina displays and ambient light sensors (MacBooks, iMacs, and systems connected to an Apple Studio Display or Pro Display XDR). This setting is set per user and on by default for new users. 

If you are trying to configure a MacOS environment that relies on color sensitive work, you will want this setting turned off. TrueTone will affect the color of connected color calibrated displays effectively rendering them useless.

This script finds the current logged in user, and adjusts the `com.apple.CoreBrightness.plist` to disable TrueTone, then refreshs the appropriate processes.

This script is meant to be run on an MDM after a user logs in. 
