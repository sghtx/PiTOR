#
# Cookbook Name:: pitor
# Attribute File:: default
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
#

case platform
	when "raspbian"
		
		######################################################
		## Change The WLAN Passphrase
		## A wpa_passphrase is between 8 - 63 charaters long
		default['pitor']['wlan']['wpa_passphrase'] 			= "ChangeMe"
		## Change The TOR Nickname
		default['pitor']['Nickname']						= "ChangeMe"
		
		######################################################
		## THIS MUST BE THE DIRECTORY WHERE THE INSTALL SCRIPT WILL BE RUN
		default['pitor']['work_dir'] 						= '/home/pi/setup_pitor'

		######################################################
		## WLAN settings
		## Change ssid to your liking
		default['pitor']['wlan']['ssid'] 					= "PiTOR_AP"
		## Most likely this should not be changed
		default['pitor']['wlan']['if'] 						= "wlan0"
		## influences setup of your local access
		default['pitor']['wlan']['country']		 			= "GB"
		## only change the address in coordination with the dhcp setup
		default['pitor']['wlan']['address'] 				= "192.168.42.1"

		######################################################
		## Raspberry Pi Config
		## admin
		default['pitor']['admin']['name'] 					= "pi"
		## PASSWORD IS NOT USED IN THIS SETUP
		# default['pitor']['admin']['password'] 			= "raspberry"
		## MAIL  IS NOT USED IN THIS SETUP
		# default['pitor']['admin']['mail'] 				= 'pi@local' 	
		default['pitor']['locale']		 					= "en_GB.UTF-8"
			
		######################################################
		## to use Realtek RTL819xSU based usb WiFi adapter
		default['pitor']['wlan']['driver'] 					= "rtl871xdrv"
		default['pitor']['wlan']['hostapd_version'] 		= "hostapd_rtl819x"

		######################################################
		## DHCP setup
		## generally this should not be changed
		######################################################
		default["pitor"]["dhcpd_domain_name"] 				= "local"
		default['pitor']['host_name'] 						= "pitor"
		default['pitor']['dhcpd_subnet'] 					= "192.168.42.0"
		default['pitor']['dhcpd_netmask'] 					= "255.255.255.0"
		default['pitor']['dhcpd_range'] 					= "192.168.42.10 192.168.42.50"
		default['pitor']['dhcpd_routers'] 					= "192.168.42.1"
		default['pitor']['dhcpd_broadcast_address'] 		= "192.168.42.255"
		default['pitor']['dhcpd_domain_name_servers'] 		= "8.8.8.8,8.8.4.4"
		default['pitor']['dhcpd_default_lease_time'] 		= "600"
		default['pitor']['dhcpd_max_lease_time'] 			= "7200"
				
		######################################################
		## TOR config
		default['pitor']['VirtualAddrNetwork'] 				= "10.192.0.0/10"
		# not in use
		# default['pitor']['ssh_port'] 						= '222'
				
	end
	