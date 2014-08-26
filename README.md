home-server
===========

Provisioning of my home server

Go to puppet folder
>puppet apply --modulepath modules manifests/default.pp

(Sensors)[http://askubuntu.com/questions/15832/how-do-i-get-the-cpu-temperature]
(HP RAID array tools install)[http://binaryimpulse.com/2013/09/installing-hp-array-configuration-utility-hp-acu-on-ubuntu-12-04/]
(Firmware updates)[http://www.solo-technology.com/blog/2009/11/29/the-easy-way-to-update-proliant-firmware/]

# Use CPU temperature in a script
>sensors | grep -A 0 'Core 0' | cut -c16-17

Server: HP ProLiant ML350 G5

Install npm forever airsonos
Install ffmpeg