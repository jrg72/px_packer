#!/bin/bash

## sets up docker and a storage pool to be used by docker.
## an EBS volume at /dev/xvdf is REQUIRED!

exec 0<&- # close stdin

set -e -u -o pipefail

## unpack skel for this module
tar -xz \
    --preserve-permissions \
    --no-same-owner \
    --strip-components=2 \
    -f /tmp/packer-skel.tgz \
    -C / \
    ./032-docker-host

yum install -y yum-utils \
    device-mapper-persistent-data \
      lvm2

yum-config-manager \
      --add-repo \
          https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce

#systemctl enable docker.service
