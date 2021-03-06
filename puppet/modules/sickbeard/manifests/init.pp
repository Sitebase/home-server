# == Class: sickbeard
#
# Installs and configures sickbeard.
#
# === Parameters
#
# [*install_dir*]
#   Where sickbeard should be installed to. Default: /opt/sickbeard
#
# [*user*]
#   The user to run sickbeard service as. Default: sickbeard
#
# === Examples
#
# include sickbeard
#
# === Authors
#
# Andrew Harley <morphizer@gmail.com>
#
class sickbeard (
	$install_dir = '/opt/sickbeard',
	$user = 'sickbeard',
	$address = '0.0.0.0',
	$port = '8081',
	$login_user = '',
	$login_pass = '',
) {

	# Install required  dependencies. Doing it this way to get around conflicts
	# from other modules...
	if ! defined(Package['git'])  {
		package { 'git':
			ensure => installed,
		}
	}

	if ! defined(Package['python'])  {
		package { 'python':
			ensure => installed,
		}
	}

	if ! defined(Package['python-cheetah'])  {
		package { 'python-cheetah':
			ensure => installed,
		}
	}

	# Create a user to run sickbeard as
	user { $user:
		ensure     => present,
		comment    => 'SickBeard user, created by Puppet',
		system     => true,
		managehome => true,
	}

	# Clone the sickbeard source using vcsrepo
	vcsrepo { $install_dir:
		ensure   => present,
		provider => git,
		source   => 'git://github.com/junalmeida/Sick-Beard.git',
		owner    => $user,
		require  => User[$user],
	}

	file { '/etc/init.d/sickbeard':
		ensure  => file,
		content => template('sickbeard/ubuntu-init-sickbeard.erb'),
		mode    => '0755',
		require => Vcsrepo[$install_dir],
	}

	file { '/opt/sickbeard/config.ini':
		ensure  => file,
		content => template('sickbeard/config.ini.erb'),
		mode    => '0755',
		require => Vcsrepo[$install_dir],
	}

	service {'sickbeard':
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => false,
		require    => [File['/etc/init.d/sickbeard'], File['/opt/sickbeard/config.ini']],
	}

}
