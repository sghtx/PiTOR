#!/bin/sh

## update - refresh package list
sudo apt-get update -y

## upgrade - may not be what you want
sudo apt-get upgrade -y

## to not install the documentation add option:  --no-install-recommends

# install ruby (to instal chef)
sudo apt-get install --no-install-recommends ruby -f -y
sudo apt-get install --no-install-recommends ruby-dev -f -y

## install chef - knife-solo
sudo gem install --no-install-recommends require -f
sudo gem install --no-install-recommends knife-solo -f

## run the chef install pitor recipe (defined in solo_install.json)
sudo chef-solo -c ./chef-repo/solo.rb -j ./chef-repo/pitor_install.json
