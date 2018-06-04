#!/usr/bin/env bash

set -e

# set bash-commons
commons="ops-gcp-kubernetes/ops-bash-commons"

# script dependencies
source ${commons}/functions/checks.sh
source ${commons}/gcloud/functions/debug.sh

# gcloud verbosity
debug=false
gcloudDebug

# requirements
checkProgs gcloud

# gcloud work
${gcloud} compute images create jenkins-home-image --source-uri \
https://storage.googleapis.com/solutions-public-assets/jenkins-cd/jenkins-home-v3.tar.gz

${gcloud} compute disks create --size=50GB jenkins-home --image jenkins-home-image
