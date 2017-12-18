# IaC to Deploy Jenkins to Google Kubernetes Engine [![Build Status](https://travis-ci.org/lzysh/ops-gke-jenkins.svg?branch=master)](https://travis-ci.org/lzysh/ops-gke-jenkins) [![codecov](https://codecov.io/gh/lzysh/ops-gke-jenkins/branch/master/graph/badge.svg)](https://codecov.io/gh/lzysh/ops-gke-jenkins)

This will get you a 'production' ready and easily supported version of Jenkins running on Google Kubernetes Engine.

# Pre-reqs:
Google Cloud Platform account:

[Google Cloud Platform Free Tier](https://cloud.google.com/free)

Domain registrar (..any is fine, I use Google):
*NOTE: You don't actually need to have a domain registrar for code to run, however it’s needed if you want to generate a usable application with DNS and a SSL certificate from Let’s Encrypt.*

[Google Domains *BETA*](https://domains.google/#/)

# Setup
## Click this:

[![Open in Cloud Shell](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/lzysh/ops-IaC.git&page=shell)
## Pull down needed submodules:
```none
$ git submodule update --remote --recursive --init
```
Edit the build.sh to sync up with your environment:

## Billing & Folder ID:
You can get your billing ID from the console under Billing > Overview.
Leave folderID blank if you're not using folders otherwise add the folder ID you want this project to go in.
```none
billingId=0XXXXX-0XXXXX-0XXXXX
folderId=
```
## Set your DNS zone:
```none
dnsZone=test.lzy.sh
```
## Disable other applications
```none
# SonarQube install (true/false)
sonar=false
sonarDomain=cq.${dnsZone}

# Jenkins install (true/false)
jenkins=true
jenkinsDomain=ci.${dnsZone}

# Upsource install (true/false)
upsource=false
upsourceDomain=cr.${dnsZone}
```

## If you're building a production environment:
```none
# this option is for using the production Let's Encrypt API and sets some different GKE cluster options
production=true
```
## Set Let's Encrypt email:
```none
# email for Let's Encrypt SSL certificate notifications
legoEmail=kube-ssl@lzy.sh
```
## Run the build:
```none
$ ./build.sh
```

To cleanup delete the project you created or look at the test.sh script for cleanup commands.