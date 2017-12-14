# IaC to Deploy Jenkins to Google Kubernetes Engine [![Build Status](https://travis-ci.org/lzysh/ops-gke-jenkins.svg?branch=master)](https://travis-ci.org/lzysh/ops-gke-jenkins) [![codecov](https://codecov.io/gh/lzysh/ops-gke-jenkins/branch/master/graph/badge.svg)](https://codecov.io/gh/lzysh/ops-gke-jenkins)

This will get you a 'production' ready easily supported version of Jenkins running on Google Kubernetes Engine.

## Pre-reqs:
Google Cloud Platform account:

[Google Cloud Platform Free Tier](https://cloud.google.com/free)

Domain registrar (..any is fine, I use Google):

[Google Domains *BETA*](https://domains.google/#/)

## Setup
Click this:
[![Open in Cloud Shell](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/lzysh/ops-IaC.git&page=shell)
```none
$ git submodule update --remote --recursive --init
```

[Create a Google Cloud Platform project](https://cloud.google.com/resource-manager/docs/creating-managing-projects#creating_a_project)
(Your user will need "Project Creator" IAM role.)
```none
$ gcloud projects create my-new-wizzy-project --name="[Wizzy Project]"
$ gcloud config set project my-new-wizzy-project
$ gcloud alpha billing projects link my-new-wizzy-project --billing-account=[Your Billing ID]
```

[Create a managed dns zone in Google Cloud DNS](https://cloud.google.com/dns/quickstart#create_a_managed_zone_and_a_record).

*NOTE: You don't actually need to have a domain registrar for code to run, however it’s needed if you want to generate a usable application with DNS and a SSL certificate from Let’s Encrypt.*
```none
$ gcloud dns managed-zones create test-lzy-sh --description="My test zone" --dns-name="test.lzy.sh"
```

Register that zone with your domain name registrar: 
```none
$ gcloud dns record-sets list --zone test-lzy-sh
NAME          TYPE  TTL    DATA
test.lzy.sh.  NS    21600  ns-cloud-b1.googledomains.com.,ns-cloud-b2.googledomains.com.,ns-cloud-b3.googledomains.com.,ns-cloud-b4.googledomains.com.
test.lzy.sh.  SOA   21600  ns-cloud-b1.googledomains.com. cloud-dns-hostmaster.google.com. 1 21600 3600 259200 300
```
This will show your NS record, grab the DATA and and create a NS record on your registrar. 

Enable Kubernetes API:
```none
$ gcloud services enable container.googleapis.com
```
Edit the build.sh to sync up with your environment:
```none
$ vi build.sh [Scroll down to "# build script setup" section]

# build script setup
sonar=false
jenkins=true
upsource=false

production=false
upgrade=false
backup=true

secret=`openssl rand -base64 12`
project=my-new-wizzy-project
zone=us-east1-b
region=us-east1
cluster=dev-tools-cluster
dnsZone=test.lzy.sh
jenkinsDomain=ci.${dnsZone}
upsourceDomain=cr.${dnsZone}
sonarDomain=cq.${dnsZone}
instance=dev-tools-instance
legoEmail=wizzy@domain.com
serviceAccount=dev-tools-cloud-sql
```

Run the build:
```none
$ ./build.sh
```
Ingress on GCP takes some time could be up to 10/15 minutes. You also have DNS records updating and kube-lego generating ssl certificates once that is done. Go have some coffee, come back, build a pipeline and write some code.

To cleanup delete the project you created or look at the test.sh script for cleanup commands.
