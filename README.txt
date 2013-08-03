Install Opscode Chef-Solo and a TOR WiFi router with a Chef recipe on Raspberry Pi.

>>> This will only run if the Raspberry Pi ethernet port is connected to the Internet !


setup_pitor.tar.gz contains all the files in the directory setup_pitor

Read the more extensive documentation: PiTOR_info.pdf

Send setup_pitor.tar.gz from a windows workstation to a Raspberry Pi target:
- Start psftp (PuTTY FTP) on the mswindows workstation
- Open psftp connection:   open ip_nr
- Send file with psftp:	 put x:\dir\setup_pitor.tar.gz
 
Unzip the configuration file on the Pi:
- cd /home/pi/
- sudo tar xzvf setup_pitor.tar.gz

EDIT Chef Attributes Files:
- sudo nano /home/pi/setup_pitor/chef-repo/cookbooks/pitor/attributes/default.rb
- At least configure the Access point password
	
To run the installation file:
- cd /home/pi/setup_pitor/
- sudo ./_start_here_install_chef_wheezy_pitor.sh

Restart: sudo shutdown -r now


>>> Only plug-in a USB WiFi/WLAN adapter when the power is off.

Find networkaddress  ifconfig -a

__________________________________________________
Compatible USB WiFi sticks
This is tested with a TP-Link adapter with a Realtek Semiconductor Corp. RTL8188CUS chipset

__________________________________________________
TODO
Create a list of USB WiFi sticks that function and add the the installation of the needed software (drivers, hostapd, etc.) and the configuration to the chef recipe.
Please tell your results with USB sticks.

__________________________________________________
Help

If the Access Point does not show up in the WiFi list, than check the network setup of the Pi.

Check:  sudo ifconfig
Result: wlan0 must have an ip address, default is 192.168.42.1

To set the network address of wlan0 on the Raspberry Pi commandline:
sudo ifconfig wlan0 192.168.42.1
