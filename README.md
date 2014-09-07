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


wget -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&tl=en&q=we+noticed+that+it+is+getting+hot+inside+here"
wget -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&tl=nl&q=Er+is+iemand+aan+de+deur"
wget -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&tl=nl&q=het+eten+is+gereed"


Network speed test apartment
----------------------------
All test are done from laptop1 to server.

|     Test    |   Interval   |   Transfer  |   Bandwidth    |
| ----------- | ------------ | ----------- | -------------- |
| From wifi   | 0.0-10.5 sec | 19.2 MBytes | 15.4 Mbits/sec |
| From switch | 0.0-10.0 sec | 1.10 GBytes | 942 Mbits/sec  |
| From router | 0.0-10.0 sec | 1.10 GBytes | 941 Mbits/sec  |

Groups, users and paths
-----------------------

|     user     | uid |       group        | gid |                                        description                                         |        home       |
| ------------ | --- | ------------------ | --- | ------------------------------------------------------------------------------------------ | ----------------- |
| media        | 996 | media              | 996 | This user folder will contain all media files. So apps will also write to this home folder | /home/media       |
| couchpatato  | 997 | couchpatato, media | 997 |                                                                                            | /opt/couchpatato  |
| sickbeard    | 998 | sickbeard, media   | 998 |                                                                                            | /opt/sickbeard    |
| transmission | 999 | transmission       | 999 | Download torrent files                                                                     | /opt/transmission |

Info
----
All users sickbeard, transmission and couchpotato should all be added to the media group.
I didn't find a good way to do this using inheritance of the puppet modules. So for the moment this needs to be done using commands after you've run the puppet script

sudo usermod -a -G media plex
sudo usermod -a -G media sickbeard
sudo usermod -a -G media wim
sudo usermod -a -G media couchpotato
sudo usermod -a -G media debian-transmission

Folders created in tranmission module should get 760 rights.

sudo chown media:media /home/media/videos
sudo chown media:media /home/media/series
sudo chown media:media /home/media/downloads
sudo chmod 770 /home/media/videos
sudo chmod 770 /home/media/series
sudo chmod 770 /home/media/downloads

### Tranmission config
In the new ubuntu it's not /etc/init.d anymore but /etc/init/transmission-daemon.conf. Open in vim and change the user and group to "media".

chown media:media /etc/transmission-daemon/settings.json
chown -R media:media /var/lib/transmission-daemon/downloads/
chown -R media:media /var/lib/transmission-daemon/info/

I've also replace the transmission conf (/etc/transmission/settings.json) with the one in the root of the repo

Install plex
* Get last download url for plex from https://plex.tv/downloads
* wget plexurl.deb
* sudo dpkg -i plexmediaserver_xxx_amd64.deb

Plex logs = /var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Logs

Install subliminal
http://www.randomlinuxstuff.tk/2013/02/install-subliminal-command-line.html

Download subtitles for all media files, this can be run in a cron or a hook of the plex update
subliminal -l nl -- /home/media/


http://ubuntuforums.org/showthread.php?t=2210449
http://blog.specialistdevelopment.com/tutorial/add-new-drive-array-to-linux-hp-server

/etc/fstab
/dev/cciss/c0d1p1       /media/storage  ext3    defaults        0       0

scanner
https://help.ubuntu.com/community/ScanningHowTo
scanimage --format=tiff --resolution 300 > test2.tiff

### login as user 
 
su sickbeard -