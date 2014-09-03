cd puppet/modules

# Delete all empty repo folders
find . -maxdepth 1 -empty -type d -delete

if [ -d apt ]; then
  cd apt && git pull && cd ..
else
  git clone https://github.com/puppetlabs/puppetlabs-apt.git apt
fi

if [ -d ssh ]; then
  cd ssh && git pull && cd ..
else
  git clone https://github.com/saz/puppet-ssh.git ssh
fi

if [ -d stdlib ]; then
  cd stdlib && git pull && cd ..
else
  git clone https://github.com/puppetlabs/puppetlabs-stdlib.git stdlib
fi

if [ -d vcsrepo ]; then
  cd vcsrepo && git pull && cd ..
else
  git clone https://github.com/puppetlabs/puppetlabs-vcsrepo.git vcsrepo
fi

if [ -d couchpotato ]; then
  cd couchpotato && git pull && cd ..
else
  git clone https://github.com/morphizer/puppet-couchpotato.git couchpotato
fi

if [ -d transmission_daemon ]; then
  cd transmission_daemon && git pull && cd ..
else
  git clone https://github.com/olbat/puppet-transmission_daemon.git transmission_daemon
fi

if [ -d sickbeard ]; then
  cd sickbeard && git pull && cd ..
else
  git clone https://github.com/morphizer/puppet-sickbeard.git sickbeard
fi
