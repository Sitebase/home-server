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

$devPackages = [ 'git-core', 'curl', 'vim', 'autoconf', 'make', 'htop', 'unzip']
package { $devPackages:
	ensure  => 'installed',
	require => Exec['apt-get update'],
}

exec { 'apt-get update2':
	command => 'apt-get update',
}
