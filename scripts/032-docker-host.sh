#!/bin/bash

## sets up docker and a storage pool to be used by docker.
## an EBS volume at /dev/xvdf is REQUIRED!

exec 0<&- # close stdin

set -e -u -o pipefail

export DOCKER_VERSION=17.03.1.ce-1.el7.centos.x86_64


## unpack skel for this module
#tar -xz \
#    --preserve-permissions \
#    --no-same-owner \
#    --strip-components=2 \
#    -f /tmp/packer-skel.tgz \
#    -C / \
#    ./032-docker-host

yum install -y yum-utils \
    device-mapper-persistent-data \
      lvm2

yum-config-manager \
      --add-repo \
          https://download.docker.com/linux/centos/docker-ce.repo

cd /tmp && yumdownloader docker-ce-${DOCKER_VERSION} docker-ce-selinux && yum localinstall -y docker-ce*

systemctl enable docker.service
