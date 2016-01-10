#!/bin/bash

wget http://apt.puppetlabs.com/pool/trusty/PC1/p/puppet-agent/puppet-agent_1.3.2-1trusty_amd64.deb
dpkg -i ./puppet-agent_1.3.2-1trusty_amd64.deb
rm -f ./puppet-agent_1.3.2-1trusty_amd64.deb
/opt/puppetlabs/bin/puppet module install thias-vsftpd
apt-get install -y git
git clone https://github.com/jpadams/lvm_ftp.git /etc/puppetlabs/code/environments/production/modules/lvm_ftp
/opt/puppetlabs/bin/puppet apply -e "include lvm_ftp"
