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
	'hddtemp'					# View hard disk temperature
]
package { $devPackages:
	ensure  => 'installed',
	require => Exec['apt-get update'],
}

exec { 'apt-get update2':
	command => 'apt-get update',
}

include couchpotato 
include sickbeard 

class {'transmission_daemon':
  download_dir => "/home/wim/Videos",
  incomplete_dir => "/tmp/downloads",
  rpc_url => "/transmission/",
  rpc_port => 9091,
  rpc_whitelist => ['*.*.*.*'],
  blocklist_url => 'http://list.iblocklist.com/?list=bt_level1',
}