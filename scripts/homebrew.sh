#! /bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Taps
brew tap homebrew/cask-versions

# Install CLI
brew install node@17 yarn cocoapods watchman android-platform-tools

# Install Apps
brew install --cask notion slack visual-studio-code postman android-studio reactotron zulu11
