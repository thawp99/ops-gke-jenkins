#!/usr/bin/env bash

# set environment
source setEnv.sh

# source in functions:
for file in ${functions}/*
do
        source ${file}
done

# depends
cmd="ops-common/gcloud/setConfig.sh -p ${project} -z ${zone}"
echoBlue "Running dependency: ${cmd}"
${cmd}

cmd="ops-common/gcloud/createK8sCluster.sh -c ${clusterName}"
echoBlue "Running dependency: ${cmd}"
${cmd}

# test createDisk.sh
cmd="./createDisk.sh"
${cmd}
results

# test start.sh
cmd="ops-common/kubectl/start.sh -a jenkins -d ${domainName}"
${cmd}
results

# cleanup
if [ "${cleanup}" = true ]; then
	cmd="kubectl delete ns jenkins"
	echoBlue "Running cleanup command: ${cmd}"
        ${cmd}
	cmd="gcloud container clusters delete ${clusterName}"
	echoBlue "Running cleanup command: ${cmd}"
        ${cmd}
	cmd="gcloud compute images delete jenkins-home-image"
	echoBlue "Running cleanup command: ${cmd}"
        ${cmd}
	cmd="gcloud compute disks delete jenkins-home"
	echoBlue "Running cleanup command: ${cmd}"
        ${cmd}
fi

# fail overall script if any tests fail
if [ "${fail}" = true ]; then
        exit 1
fi
