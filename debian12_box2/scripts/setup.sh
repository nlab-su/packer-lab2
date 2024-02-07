#!/bin/bash -eux

# Install sudo
apt-get install sudo
touch /etc/sudoers.d/vagrant

# Add vagrant user to sudoers.
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

useradd -g vgarant -G sudo vagrant
passwd vagrant

mkdir -m 700 /home/vagrant/.ssh
curl -k https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub > /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh/authorized_keys 
# Disable daily apt unattended updates. Is this needed for Debian?
# echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic
