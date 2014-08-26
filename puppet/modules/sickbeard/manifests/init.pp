class sickbeard {

  group { 'sickbeard':
    gid => '998',
  }
    
  user { 'sickbeard':
    uid => '998',
  }
  
  exec { 'git_clone_sickbeard':
    command => 'git clone --depth 1 git://github.com/midgetspy/Sick-Beard.git sickbeard',
    cwd     => '/opt',
    path    => '/usr/bin',
    require => Package['git'],
  }

  file { '/opt/sickbeard':
    ensure  => 'directory',
    owner   => 'wim',
    group   => 'wim',
    mode    => '0700',
    recurse => 'true',
    require => Exec['git_clone_sickbeard'],
  }

}