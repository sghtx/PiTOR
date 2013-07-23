Description
===========

Sets up TOR on Raspberry Pi

Requirements
============

## Platform:

* Wheezy

## Cookbooks:

* none

Attributes
==========

See `attributes/default.rb` for default values.

* `node['pitor']['fqdn']` - use as hostname for /etc/hostname and /etc/hosts
* `node['pitor']['hostname']` - hostname for /etc/hostname and /etc/hosts
* `node['pitor']['']` - 
* `node['pitor']['']` - 

Recipes
=======

default
-------

The templates add
/etc/hosts
/etc/hostname


Usage
=====

Include `recipe[pitor]` on systems where you want to


License and Author
==================

Author:: Henk Scholten <hscholten@paraplu.nl>

Copyright:: 2013, H. Scholten

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
