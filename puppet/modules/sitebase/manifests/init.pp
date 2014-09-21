class sitebase {}

class sitebase::motd inherits ::motd {
  File["/etc/motd"] {
    source => "puppet:///modules/sitebase/motd"
  }
}

#class sitebase::transmission_daemon (
#  $download_dir = "/var/lib/transmission-daemon/downloads",
#  $incomplete_dir = undef,
#  $rpc_url = undef,
#  $rpc_port = 9091,
#  $rpc_user = "transmission",
#  $rpc_password = undef,
#  $rpc_whitelist = undef,
#  $blocklist_url = undef,
#  $script_torrent_done = undef
#) inherits ::transmission_daemon {
#
#	File['settings.json'] {
#		content => template("${module_name}/transmission.json.erb")
#	}
#
#}

class sitebase::transmission_daemon {
  
  File['/etc/transmission-daemon/settings.json'] {
    ensure => file,
    content => "blabla"
  }

}