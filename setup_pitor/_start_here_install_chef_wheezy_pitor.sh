#!/bin/sh

## update - refresh package list
sudo apt-get update -y

## upgrade - may not be what you want
sudo apt-get upgrade -y

# install ruby (to instal chef)
## to not install the documentation add option:  --no-install-recommends
sudo apt-get install --no-install-recommends ruby -f -y
sudo apt-get install --no-install-recommends ruby-dev -f -y

## install chef - knife-solo
## to not install the documentation add option:  --no-rdoc --no-ri
sudo gem install --no-rdoc --no-ri  require -f
sudo gem install --no-rdoc --no-ri knife-solo -f

## run the chef install pitor recipe (defined in solo_install.json)
sudo chef-solo -c ./chef-repo/solo.rb -j ./chef-repo/pitor_install.json
