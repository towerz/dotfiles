#! /bin/bash

echo "Making sure sudo will work without interrupting execution"
sudo -v

echo "Setting up environment"
which -s brew
if [[ $? != 0 ]]; then
  echo "Install homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install caskroom/cask/brew-cask
  brew tap homebrew/versions
  brew tap caskroom/versions
fi
brew update
brew upgrade --all

brew install mas

if [[ -n $APP_STORE_ACCOUNT && -n $APP_STORE_PASSWD ]]; then
  echo "App Store setup"
  echo "::app installs"
  mas install 918858936 # Airmail 3
  mas install 595191960 # CopyClip
  mas install 823766827 # OneDrive
  mas install 485812721 # TweetDeck
  mas install 410628904 # Wunderlist
  mas install 497799835 # Xcode
fi

echo "Displaying Xcode license"
sudo xcodebuild -license

echo "Install core apps"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
echo "::browsers"
brew cask install google-chrome firefox brave vivaldi
brew cask install flash
echo "::music"
brew cask install spotify spotify-notifications amazon-music music-manager
echo "::password managers"
brew cask install dashlane enpass lastpass
echo "::quicklook plugins"
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package provisionql qlvideo
echo "::utilities"
brew cask install caffeine dropbox google-drive spectacle the-unarchiver
echo "::messengers"
brew cask install skype telegram whatsapp

echo "Install developer tools"
echo "::unix"
# Don't forget to add `$(brew --prefix coreutils)/libexec/gnubin` to $PATH
brew install coreutils
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
brew install moreutils findutils
brew install gnu-sed --with-default-names
brew install bash bash-completion2

# Switch to brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/bash
fi

brew install ctags openssl
brew install vim --override-system-vi
brew install homebrew/dupes/grep homebrew/dupes/openssh homebrew/dupes/screen

echo "::general"
brew install git hub
brew install wget --with-iri
brew install nginx
brew install ssh-copy-id
brew install binutils
brew install ack tree vbindiff pv speedtest_cli
brew install imagemagick --with-webp
brew cask install atom iterm2 rowanj-gitx

echo "::network"
brew cask install tcpflow tcpreplay tcptrace
brew cask install charles

echo "::languages"
brew install node ringojs
brew install rbenv ruby-build
brew install go
brew install lua
brew cask install java java7

echo "::virtualization"
brew cask install virtualbox docker

echo "::android sdk"
brew install gradle android-sdk android-ndk
brew cask install android-studio genymotion

echo "::ios"
brew install xctool cmake ninja

# cleanup
echo "Cleanup"
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*
