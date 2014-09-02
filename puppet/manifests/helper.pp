define git_web_service ( $user = $title, $group = $title, $uid, $gid, $url ) {

    group { $user:
      gid => $uid,
    }

    user { $user:
      gid => $uid,
      uid => $uid,
      require => Group[$user],
    }

    file { "/opt/$user":
      ensure => directory,
      owner => $user,
      group => $user,
      recurse => true,
    }

    exec { "git_sync_$user":
      command => "sudo -u $user git clone $url .; sudo -u $user git pull origin master",
      cwd => "/opt/$user",
      path => '/usr/bin',
      require => File["/opt/$user"],
    }
    
}