class subliminal {
	
	if ! defined(Package['git-core']) {
		package { 'git-core':
			ensure => installed,
		}
	}

	if ! defined(Package['python-pip']) {
		package { 'python-pip':
			ensure => installed,
		}
	}

	vcsrepo { '/opt/subliminal':
		ensure   => present,
		provider => git,
		source   => 'git://github.com/Diaoul/subliminal.git',
		owner    => 'media',
	}

	exec { "install":
    	command => "git checkout -t origin/0.7.x && pip install guessit==0.7.0 && python setup.py install",
    	path    => "/usr/local/bin/:/bin/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin",
    	cwd 	=> "/opt/subliminal",
    	require => Vcsrepo['/opt/subliminal']
	}


}