#!/bin/bash

set -e

echo "Shell Provisioning"

# Load up the release information
. /etc/lsb-release

# Initial apt-get update
apt-get update > /dev/null

##################################
# Install Build Essential
##################################
echo "Installing Build Essential"
apt-get install build-essential -y > /dev/null

##################################
# Install Ruby Dev
##################################
echo "Installing Ruby Dev"
apt-get install ruby-dev -y > /dev/null

##################################
# Install Git
##################################
echo "Installing Git"
apt-get install git -y > /dev/null

##################################
# Install Puppet
##################################
echo "Installing Puppet"
REPO_DEB_URL="http://apt.puppetlabs.com/puppetlabs-release-${DISTRIB_CODENAME}.deb"
repo_deb_path=$(mktemp)

wget --output-document="${repo_deb_path}" "${REPO_DEB_URL}" > /dev/null
dpkg -i "${repo_deb_path}" > /dev/null
apt-get update > /dev/null

apt-get -y install puppet > /dev/null

echo "Puppet installed"

##################################
# Install Librarian Puppet
##################################
echo "Installing Librarian Puppet"
gem install librarian-puppet -v 2.1.0

echo "Librarian Puppet installed"