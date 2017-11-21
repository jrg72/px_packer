#!/bin/bash

exec 0<&- # close stdin

set -e -u -o pipefail

## unpack skel for this module
tar -xz \
    --preserve-permissions \
    --no-same-owner \
    --strip-components=2 \
    -f /tmp/packer-skel.tgz \
    -C / \
    ./029-puppet

rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

yum -y install puppet-agent awscli jq

/opt/puppetlabs/puppet/bin/gem install librarian-puppet hiera-eyaml

