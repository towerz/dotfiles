#! /usr/bin/env bash

# Simple script for setting up my OSX dev environment

[[ $(uname) != 'Darwin' ]] && echo "This script should only be run on macOS. Aborting." && exit 1

hostname=$1
if [[ -n "$hostname" ]]; then
  echo "Setting hostname to '$hostname'..."
  scutil --set HostName "$hostname"
  compname=$(sudo scutil --get HostName | tr '-' '.')
  echo "Setting computer name to '$compname'"
  scutil --set ComputerName "$compname"
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$compname"
fi

pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
[[ -f $pub ]] || ssh-keygen -t rsa

echo 'Copying public key to clipboard. Paste it into your Github account...'
[[ -f $pub ]] && cat $pub | pbcopy
open 'https://github.com/account/ssh'

if [[ -f "brew.sh" ]]; then
  echo "Setting up applications"
  source "brew.sh"
fi

if [[ -f ".macos" ]]; then
  echo "Tweaking macOS settings..."
  source ".macos"
fi
