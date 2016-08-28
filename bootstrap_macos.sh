#! /usr/bin/env bash

# Simple script for setting up my OSX dev environment

[[ $(uname) != 'Darwin' ]] && echo "This script should only be run on macOS. Aborting." && exit 1

echo -n "Enter hostname of the new machine: "
read hostname
echo "Setting hostname to '$hostname'..."
scutil --set HostName "$hostname"
compname=$(sudo scutil --get HostName | tr '-' '.')
echo "Setting computer name to '$compname'"
scutil --set ComputerName "$compname"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$compname"

if [[ -f "brew.sh" ]]; then
  echo "Setting up applications"
  source "brew.sh"
fi

if [[ -f ".macos" ]]; then
  echo "Tweaking macOS settings..."
  source ".macos"
fi
