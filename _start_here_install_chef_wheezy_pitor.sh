#!/bin/sh

## update - refresh package list
sudo apt-get update -y

## upgrade - may not be what you want
sudo apt-get upgrade -y

# install ruby (to instal chef)
sudo apt-get install ruby -f -y
sudo apt-get install ruby-dev -f -y

## install chef - knife-solo
sudo gem install require -f
sudo gem install knife-solo -f

## run the chef install pitor recipe (defined in solo_install.json)
sudo chef-solo -c ./chef-repo/solo.rb -j ./chef-repo/pitor_install.json
