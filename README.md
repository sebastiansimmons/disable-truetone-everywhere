# falsetone.sh - Disable TrueTone on MacOS
A bash script for disabling TrueTone on MacOS for the current logged in user.

[TrueTone](https://support.apple.com/en-us/HT208909) is a MacOS feature that adjusts the white point and color output of displays on many MacOS systems. This setting is per user and on by default. 

If you are trying to administrate a MacOS environment that relies on color accurate work, especially if you are attaching color accurate monitors, you will want this setting disable for every user as it will throw color accurate displays out of accuracy.

This script finds the current logged in user, and adjusts the `com.apple.CoreBrightness.plist` to disable TrueTone, then refreshs the appropriate processes.

This script is meant to be run on an MDM after a user logs in. 
