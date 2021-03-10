#!/bin/bash

metadata="http://169.254.169.254/latest/meta-data/"

curl -w "\n" $metadata/hostname > metadata.txt
curl -w "\n" $metadata/iam/info >> metadata.txt
curl -w "\n" $metadata/security-groups >> metadata.txt

