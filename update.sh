# Run update to pull in the last version of GIT
# and auto execute this version on the server
# This script MUST BE run as root

# Pull last changes from git
echo '--> Update repository'
git pull origin master -f

# Install dependencies
echo '--> Install dependencies'
./bootstrap.sh

# Provision server
echo '--> Provision server'
cd puppet
puppet apply --modulepath modules manifests/default.pp

echo '--> Update done'