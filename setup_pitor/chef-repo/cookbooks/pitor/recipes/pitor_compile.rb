#
# Cookbook Name:: pitor
# Recipe:: pitor_compile
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

#######################################################
## uncompress the complete tar.gz install file from Realtek
##command "sudo cd /home/pi/setup_pitor/support/RTL8188C_8192C_USB_linux_v3.4.4_4749.20121105/wpa_supplicant_hostapd"
##command "sudo unzip wpa_supplicant_hostapd-0.8_rtw_20120803.zip"
##command "sudo cd /home/pi/setup_pitor/support/RTL8188C_8192C_USB_linux_v3.4.4_4749.20121105/wpa_supplicant_hostapd/wpa_supplicant_hostapd-0.8_rtw_20120803/wpa_supplicant_hostapd-0.8/hostapd"

#######################################################
## use only the uncompressed hostapd directory
execute "change dir to compile hostapd for Realtek chipset" do
  command "cd /home/pi/setup_pitor/support/wpa_supplicant_hostapd-0.8/hostapd/"
  action :run
end

#######################################################
## compile
execute "compile hostapd for Realtek chipset" do
  command "sudo make"
  action :run
end

#######################################################
## install
execute "install hostapd for Realtek chipset" do
  command "sudo make install"
  action :run
end

#######################################################
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

execute "replace distribution hostapd with compatible compiled version" do
  command "sudo ln -s /usr/local/bin/hostapd /usr/sbin/hostapd"
  only_if { ::File.exists?("/usr/local/bin/hostapd")}
  action :run
end

#######################################################
## go back to setup dir
execute "change dir to /home/pi/setup_pitor/" do
  command "cd /home/pi/setup_pitor/"
  action :run
end

########################################################
## For Reference:
## get compiled hostapd for Realtek chipset from adafruit
#execute "get hostapd for wlan from adafruit" do
#  command 'sudo wget http://www.adafruit.com/downloads/adafruit_hostapd.zip'
#  command 'sudo unzip adafruit_hostapd.zip'
#  command 'sudo mv /usr/sbin/hostapd /usr/sbin/hostapd.ORIG'
#  command 'sudo mv hostapd /usr/sbin'
#  command 'sudo chmod 755 /usr/sbin/hostapd'
#  action :run
#end
