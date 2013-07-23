#
# Cookbook Name:: pitor
# Recipe:: pitor_testing
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

#######################################################
#######################################################
## Testing

## activate forwarding immediately
#execute "setup ip forwarding" do
#  command 'sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"'
#  action :run
#end

## restart the network
#execute "networking restart" do
#  command "/etc/init.d/networking restart"
#  action :run
#end

execute "start daemons" do
  command "sudo service hostapd start"
  command "sudo service isc-dhcp-server start"
  command "sudo service tor start"
  action :run
end

## run ohai to get new information
execute "run ohai to get new information" do
  command "ohai"
  action :run
  # ignore_failure true
end

execute "test" do
  command "sudo /usr/sbin/hostapd /etc/hostapd/hostapd.conf"
  action :run
end

execute "test" do
  command "sudo iptables -t nat -S  > test_iptables.txt"
  command "sudo iptables -t nat -L  > test_iptables.txt"
  command "sudo iptables -S > test_iptables.txt"
  action :run
end
