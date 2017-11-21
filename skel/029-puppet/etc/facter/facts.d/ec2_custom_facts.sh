#!/bin/bash
/bin/aws ec2 describe-tags --filters "Name=resource-id,Values=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)" --region $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone/|sed s'/.$//') | jq -r '.Tags[] | "ec2_tag_" + .Key + "=" + .Value'
echo "ec2vpcid=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$(curl -s http://169.254.169.254/latest/meta-data/mac)/vpc-id)"
echo "ec2_vpc_cidr=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$(curl -s http://169.254.169.254/latest/meta-data/mac)/vpc-ipv4-cidr-block)"
echo "ec2region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone/|sed s'/.$//')"
exit 0

