#!/usr/bin/env bash

# source in environment and functions
source setEnv.sh
source ${functions}/checks.sh

checkProgs gcloud

# gcloud work
gcloud compute images create jenkins-home-image --source-uri \
https://storage.googleapis.com/solutions-public-assets/jenkins-cd/jenkins-home-v3.tar.gz

gcloud compute disks create --size=50GB jenkins-home --image jenkins-home-image