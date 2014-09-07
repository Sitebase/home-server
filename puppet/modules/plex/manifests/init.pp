class plex {
	
	user { "plex":
		ensure     => present,
		comment    => 'Plex user, created by Puppet',
		system     => true,
		managehome => true,
		groups 		=> ["media"]
	}

	exec { "download":                                                                                                                     
        command => "wget -O plex.dev http://downloads.plexapp.com/plex-media-server/0.9.9.14.531-7eef8c6/plexmediaserver_0.9.9.14.531-7eef8c6_amd64.deb",                                                         
        cwd => "/tmp",
        creates => "/tmp/plex.deb",                                                              
        require => User['plex'],
        user => "plex",                                                                                                          
    }

    package {'install': 
    	ensure    => installed,
    	provider  => dpkg, 
		source    => '/tmp/plex.deb',
		require		=> Exec['download']  
	}

}