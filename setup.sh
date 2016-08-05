#!/bin/bash

sudo apt-get update -y

if [ -d "/home/travis/" ]; then
  sudo apt-get install nodejs ruby-dev -y
else
  sudo apt-get install nodejs git ruby ruby-dev curl -y
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  curl -sSL https://get.rvm.io | bash -s stable --ruby
fi
