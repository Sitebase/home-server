include apt

apt::ppa { 'ppa:team-xbmc/ppa': }

Exec {
	path => [
		'/usr/bin',
		'/bin',
		'/usr/sbin',
		'/sbin',
		'/usr/local/bin',
		'/usr/local/sbin',
		'/opt/vagrant_ruby/bin',
		'/app/bin',
		'/app/vendor/php5-fpm/bin'
	]
}

exec { 'apt-get update':
	command => 'apt-get update',
}

include motd

$devPackages = [ 
	'git-core', 
	'curl', 
	'vim', 
	'autoconf', 
	'make', 'htop', 'unzip', 
	'nodejs', 'npm', 
	'lm-sensors',				# View sensor temperatures and other values
	'hddtemp',					# View hard disk temperature
	'iperf',					# Do network speed test
	'avahi-utils'				# This is needed for plex installation
]
package { $devPackages:
	ensure  => 'installed',
	require => Exec['apt-get update'],
}

group { 'media':
  gid => 996,
}

user { 'media':
	gid => 996,
	uid => 996,
	ensure      => present, 
	shell       => '/bin/bash',
	home        => '/home/media/',
	managehome  => true,
	comment     => 'User that contains all media files',
	require => Group['media']
}

file { "/home/media/":
	ensure => directory,
	owner => 'media',
	group => 'media',
	recurse => true,
	mode => 760,
}

# Dir for the downloaded videos
#file { "/home/media/videos/":
#	ensure => directory,
#	owner => 'media',
#	group => 'media',
#	recurse => true,
#	mode => 760,
#	require => File['/home/media/']
#}

# Dir that contains incomplete downloads
#file { "/home/media/downloads/":
#	ensure => directory,
#	owner => 'media',
#	group => 'media',
#	recurse => true,
#	mode => 760,
#	require => File['/home/media/']
#}

include couchpotato 
include sickbeard 

class {'transmission_daemon':
	download_dir => "/home/media/videos",
	incomplete_dir => "/home/media/downloads",
	rpc_url => "/transmission",
	rpc_port => 9091,
	rpc_whitelist => ['*.*.*.*'],
	blocklist_url => 'http://list.iblocklist.com/?list=bt_level1',
	require => File['/home/media/']
}

