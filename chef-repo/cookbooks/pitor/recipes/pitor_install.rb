#
# Cookbook Name:: pitor
# Recipe:: pitor_install
#
#
# Copyright 2013, H. Scholten - hscholten >at< paraplu >dot< nl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

########################################################
## install gem ruby shadow, this allows to create passwords
execute "install gem ruby-shadow" do
  command "sudo gem install ruby-shadow"
  action :run
  not_if "gem list | grep ruby-shadow"
end

##############################################################
## install packages 
execute "update package information" do
  command "sudo apt-get update"
  action :run
end

##############################################################
## these packages are by default on the rapsberry pi
## install here just to make sure
package "apt-utils" do
	action:install
	ignore_failure true
end

package "nano" do
	action:install
	ignore_failure true
end

package "wget" do
	action:install
	ignore_failure true
end

package "rsync" do
	action:install
	ignore_failure true
end

package "unzip" do
	action:install
	ignore_failure true
end

################################################################
## not part of raspberry basic wheezy install
package "curl" do
	action:install
	ignore_failure true
end

package "makepasswd" do
	action:install
end

## optional, handy to list directories (43,4 kb archive)
package "tree" do
	action:install
	ignore_failure true
end

##############################################################
## specific for pitor application 
package "iw" do
	action:install
end

package "rfkill" do
	action:install
end

package "bridge-utils" do
	action:install
end

package "dnsmasq" do
	action:install
end

package "iptables-persistent" do
	action:install
end

package "hostapd" do
	action:install
end

package "hostap-utils" do
	action:install
end

package "isc-dhcp-server" do
	action:install
end

package "tor" do
	action:install
	ignore_failure true
end


#package "zd1211-firmware" do
#	action:install
#end

#######################################################
## USB WiFi dongle hostapd setup for Realtek 8188 & 8192 Chipsets
## replace hostapd with pre-compiled version
execute "remove distribution hostapd if backup exists" do
  command "sudo rm /usr/sbin/hostapd"
  only_if { ::File.exists?("/usr/sbin/hostapd.orig")}
  action :run
end

execute "backup distribution hostapd" do
  command "sudo mv /usr/sbin/hostapd /usr/sbin/hostapd.orig"
  not_if { ::File.exists?("/usr/sbin/hostapd.orig")}
  action :run
end

execute "replace distribution hostapd with pre-compiled compatible version" do
  command "sudo cp /home/pi/setup_pitor/support/hostapd_RTL8188C_8192C /usr/sbin/hostapd"
  action :run
end

#######################################################
## remove WPA-Suppplicant if needed
#execute "remove WPA-Supplicant" do
#  command "sudo mv /usr/share/dbus-1/system-services/fi.epitest.hostap.WPASupplicant.service ~/"
#  action :run
#  ignore_failure true
#end

########################################################
execute "autoclean install" do
  command "sudo apt-get autoclean"
  action :run
end

