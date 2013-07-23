Install Chef with setup_chef_wheezy.tgz

This will only run if the Raspberry Pi ethernet port is connected to the the Internet!

If a new user on the target is needed:
•	Open connection with SSH to target as root
•	Adduser to target:   adduser name 

Send config file from windows workstation to target:
•	Start psftp (PuTTY FTP)  on the mswindows workstation
•	Open psftp connection:   open ip_nr
•	Send file with psftp:	 put c:\dir\setup_pitor.tar.gz
 

If the configuration file was uploaded as root:
•	sudo   mv   /root/setup_pitor.tar.gz   /home/pi/

Unzip the configuration file:
•	cd /home/pi/
•	sudo tar –xzvf setup_pitor.tar.gz
•	EDIT Chef Attributes Files:
	-	/home/pi/setup_pitor/chef-repo/cookbooks/pitor/attributes/default.rb
	-	Access point password
	-	Host names
	
Run the configuration file:
•	cd /home/pi/setup_pitor/
•	sudo ./_start_here_install_chef_wheezy_pitor.sh
•	Re-Boot: shutdown –r now


On Raspberry Pi:

Install wheezy on SD card
run sudo raspi-config ,starts on first boot
- Expand disk size to SD card size
- Change default password of the pï account
- Enable advanced options SSH

Only plug-in WLAN adapter when power is off.

Find networkaddress  ifconfig -a
eth0	ethernet address
wlan0	must be present

---------------------------------------------------------------------------------------

Tar Help:
•	c --- to create a tar file, writing the file starts at the beginning.
•	t --- table of contents, see the names of all files or those specified in other command line arguments.
•	x --- extract (restore) the contents of the tar file.
•	f --- specifies the filename (which follows the f) used to tar into or to tar out from; see the examples below.
•	z --- use zip/gzip to compress the tar file or to read from a compressed tar file.
•	v --- verbose output, show, e.g., during create or extract, the files being stored into or restored from the tar file.

Create TAR:		tar –cvzf  target_file.tgz   /source_directory  source_file
Untar:			tar –xvzf target_file.tgz
