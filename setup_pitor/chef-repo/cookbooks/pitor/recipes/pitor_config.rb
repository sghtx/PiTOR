#
# Cookbook Name:: pitor
# Recipe:: pitor_config
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

########################################################
## set static address on wlan adapter
ifconfig "#{node[:pitor][:wlan_address]}" do
  device #{node[:pitor][:wlan][:if]}
end

########################################################
## create configuration files

########################################################
## configure the dhcp server
template "/etc/dhcp/dhcpd.conf" do
   source "dhcpd.conf.erb"
   mode 0440
   owner "root"
   group "root"
   variables(
    	:dhcpd_domain_name => node["pitor"]["dhcpd_domain_name"],
	:dhcpd_subnet => node["pitor"]["dhcpd_subnet"],
	:dhcpd_netmask => node["pitor"]["dhcpd_netmask"],
	:dhcpd_range => node["pitor"]["dhcpd_range"],
	:dhcpd_routers => node["pitor"]["dhcpd_routers"],
	:dhcpd_broadcast_address => node["pitor"]["dhcpd_broadcast_address"],
	:dhcpd_domain_name_servers => node["pitor"]["dhcpd_domain_name_servers"],
	:dhcpd_default_lease_time => node["pitor"]["dhcpd_default_lease_time"],
	:dhcpd_max_lease_time => node["pitor"]["dhcpd_max_lease_time"]
  )
end

template "/etc/default/isc-dhcp-server" do
   source "isc-dhcp-server.erb"
   mode 0440
   owner "root"
   group "root"
    variables(
    :wlan_if => node["pitor"]["wlan"]["if"]
  )
end

########################################################
## host acces point daemon
template "/etc/default/hostapd" do
   source "hostapd.erb"
   mode 0440
   owner "root"
   group "root"
end

template "/etc/hostapd/hostapd.conf" do
   source "hostapd.conf.erb"
   mode 0440
   owner "root"
   group "root"
    variables(
    :wlan_if => node["pitor"]['wlan']['if'],
    :wlan_driver => node["pitor"]['wlan']['driver'],
    :wlan_ssid => node["pitor"]['wlan']['ssid'],
    :country => node["pitor"]['wlan']['country'],
    :wlan_wpa_passphrase => node["pitor"]['wlan']['wpa_passphrase']
  )
end

########################################################
## network
template "/etc/network/interfaces" do
   source "interfaces.erb"
   mode 0440
   owner "root"
   group "root"
    variables(
    :wlan_address => node["pitor"]["wlan"]["address"],
    :dhcpd_netmask => node["pitor"]["dhcpd_netmask"]
  )
end

template "/etc/sysctl.conf" do
   source "sysctl.conf.erb"
   mode 0440
   owner "root"
   group "root"
end

#################################################################
## Setup iptables for TOR Proxy
template "/etc/iptables/rules.v4" do
   source "rules.v4.erb"
   mode 0440
   owner "root"
   group "root"
end

#################################################################
## Setup starting iptables on boot
template "/etc/rc.local" do
   source "rc.local.erb"
   mode 0440
   owner "root"
   group "root"
end

########################################################
## TOR configuration file
template "/etc/tor/torrc" do
   source "torrc.erb"
   mode 0440
   owner "root"
   group "root"
    variables(
    :dhcpd_routers => node["pitor"]["dhcpd_routers"],
    :VirtualAddrNetwork => node["pitor"]["VirtualAddrNetwork"],
    :Nickname => node["pitor"]["Nickname"]
  )end


#######################################################
#######################################################
execute "configure daemons" do
  command "sudo update-rc.d hostapd enable"
  command "sudo update-rc.d isc-dhcp-server enable"
  command "sudo update-rc.d tor enable"
  action :run
end

########################################################
## Environment settings

########################################################
#set the editor environment variable for chef
#ruby_block "insert_editor" do
#  block do
#    file = Chef::Util::FileEdit.new("/etc/environment")
#    file.insert_line_if_no_match("export EDITOR=", 'export EDITOR="pico"')
#    file.write_file
#	end
#end

########################################################
## set the locale
#ruby_block "set_locale" do
#  block do
#    file = Chef::Util::FileEdit.new("/etc/default/locale")
#    file.insert_line_if_no_match("LANG=", 'LANG="#{node[:pitor][:locale]}"')
#    file.write_file
#	end
#end

########################################################################
## For Reference

#######################################################
## configure TOR log file
#execute "create TOR logging directory" do
#  command "sudo mkdir /var/log/tor/"
#  ignore_failure true
#  action :run
#end

#execute "configure TOR logging" do
#  command "sudo touch /var/log/tor/notices.log"
#  command "sudo chown #{node[:pitor][:admin][:name]} /var/log/tor/notices.log"
#  command "sudo chmod 644 /var/log/tor/notices.log"
#  ignore_failure true
#  action :run
#end

########################################################################
## plain router
#execute "setup iptables 1" do
#  command 'sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE'
#  command 'sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT'
#  action :run
#end

#################################################################
## Setup iptables for testing the proxy without TOR
#execute "setup iptables without TOR" do
#  ## Flush
#  command 'sudo iptables -F'
#  command 'sudo iptables -t nat -F'
#  ## new rules
#  command 'sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE'
#  command 'sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT'
#  command 'sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT'
#  command 'sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"'
#  action :run
#end

#################################################################
## Setup iptables for TOR
#execute "setup iptables TOR" do
#  ## Flush
#  command 'sudo iptables -F'
#  command 'sudo iptables -t nat -F'
#  ## new rules
#  command 'sudo iptables -t nat -A PREROUTING -i wlan0 -p tcp --dport 22 -j REDIRECT --to-ports 22'
#  command 'sudo iptables -t nat -A PREROUTING -i wlan0 -p udp --dport 53 -j REDIRECT --to-ports 53'
#  command 'sudo iptables -t nat -A PREROUTING -i wlan0 -p tcp --syn -j REDIRECT --to-ports 9040'
#  ## save setup
#  command 'sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"'
#  action :run
#end




