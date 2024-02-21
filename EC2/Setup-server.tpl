#!/bin/bash
mkdir /data/DataSync
mkdir /data/FileGateway
mkdir /mnt/nfs
aws s3 cp s3://us-west-2-aws-training/courses/spl-247/v1.0.9.prod-f1b6e83d/scripts/data/DataSync/ /data/DataSync --recursive --include '*'
aws s3 cp s3://us-west-2-aws-training/courses/spl-247/v1.0.9.prod-f1b6e83d/scripts/data/FileGateway/ /data/FileGateway --recursive --include '*'
yum install ec2-instance-connect