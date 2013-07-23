#!/bin/sh

## run the chef install pitor recipe (defined in solo_install.json)
sudo chef-solo -c ./chef-repo/solo.rb -j ./chef-repo/pitor_config.json
