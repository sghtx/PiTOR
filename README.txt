Install Chef and a TOR WiFi router with Chef

>>> This will only run if the Raspberry Pi ethernet port is connected to the the Internet !


setup_pitor.tar.gz contains all the files in the directory setup_pitor

Read the more extensive documentation: pitor_doc.pdf

Send setup_pitor.tar.gz from windows workstation to Raspberry Pi target:
•	Start psftp (PuTTY FTP) on the mswindows workstation
•	Open psftp connection:   open ip_nr
•	Send file with psftp:	 put x:\dir\setup_pitor.tar.gz
 
Unzip the configuration file:
•	cd /home/pi/
•	sudo tar –xzvf setup_pitor.tar.gz
•	EDIT Chef Attributes Files:
	-	/home/pi/setup_pitor/chef-repo/cookbooks/pitor/attributes/default.rb
	-	At least configure the Access point password
	
To run the installation file:
•	cd /home/pi/setup_pitor/
•	sudo ./_start_here_install_chef_wheezy_pitor.sh

•	Re-Boot: sudo shutdown –r now


Preparations on the Raspberry Pi:

Install wheezy on SD card
run sudo raspi-config ,starts on first boot
- Expand disk size to SD card size
- Enable advanced options SSH

Only plug-in WLAN adapter when power is off.

Find networkaddress  ifconfig -a
eth0	ethernet address
wlan0	must be present

Set network on the Raspberry Pi commandline if wlan does not start:
sudo ifconfig wlan0 192.168.42.1