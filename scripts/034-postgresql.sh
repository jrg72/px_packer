#!/bin/bash

exec 0<&- # close stdin

set -e -u -o pipefail

## unpack skel for this module
#tar -xz \
#    --preserve-permissions \
#    --no-same-owner \
#    --strip-components=2 \
#    -f /tmp/packer-skel.tgz \
#    -C / \
#    ./034-postgresql

rpm -Uvh https://yum.postgresql.org/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm
rpm -Uvh https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm


mkfs.ext4 /dev/xvdb

mkdir -p /var/lib/pgsql

echo "/dev/xvdb /var/lib/pgsql ext4 defaults 1 1" >> /etc/fstab

mount -a

yum -y groupinstall "PostgreSQL Database Server 9.6 PGDG"
yum -y groupinstall "PostgreSQL Database Server 10 PGDG"

/usr/pgsql-10/bin/postgresql-10-setup initdb

systemctl enable postgresql-10

