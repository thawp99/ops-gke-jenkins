#!/usr/bin/env bash

set -e

# check for environment config
if [ ! "${functions}" ] || [ ! "${gcloud}" ]; then
        echo "Environment not set"
        exit 1
fi

source ${functions}/checks.sh

# requirements
checkProgs gcloud

# gcloud work
${gcloud} compute images create jenkins-home-image --source-uri \
https://storage.googleapis.com/solutions-public-assets/jenkins-cd/jenkins-home-v3.tar.gz

${gcloud} compute disks create --size=50GB jenkins-home --image jenkins-home-image