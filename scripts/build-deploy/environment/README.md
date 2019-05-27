# mosip-internal

This folder has scripts that can be run to setup the dependencies for mosip such as antivirus, ldap, postgres, nginx proxy, hdfs and ssl certificate.


The dependencies required can be setup in either a single VM or multiple Virtual Machines. Each of the services described can be hosted separately.

Deploying mosip involves building and creating deployable images of the software, setting up dependencies, creating a kubernetes cluster and running the mosip micro services on them. The following sections will address these in steps.

## Setup Dependency Environment

mosip uses postgres to store data, hdfs to store files, and ldap for authorization information. In addition to these the file service requires an external virus scanning service. Since the microservices are deployed on a kubernetes cluster, a proxy service is also needed to forward requests as well as handle https. Let us setup each of these one by one.

The scripts referred to in the sections below are for a RHEL/CentOS 7.6 environment. If you choose alternate environments your setup process might vary. Also the scripts prompt the running of manual commands in places. These instructions are to be followed to complete the setup as intended.


### Setting up postgres database

Refer to the steps in the script psql-setup.sh for setting up your postgres server. It is recommended that you follow the script as closely as possible to keep configuration changes to a minimum.

### Setting up hdfs

Refer to the steps in the script hdfs-setup.sh for getting your hdfs environment up and running.

### Setting up antivirus

Refer to the steps in the script clam-setup.sh to setup clam antivirus on a virtual machine.

### Setting up ldap

Refer to the steps in the script ldap-setup.sh to setup Apache Directory Services as your ldap provider.

### Proxy setup

NGINX is used as the proxy. It has to be setup with SSL support. Use the following scripts to set these up. Follow the steps in proxy-setup.sh and then ssl-setup.sh to get your proxy running.

### Kubernetes setup

We used the Azure kubernetes service and setup a cluster with 5 nodes. The nodes had 4 vcpus and 8 GB RAM each. We recommend that you try the same. You are however free to use any kubernetes environment with your own node configurations.

## mosip build process

Refer to the readme section in the root forlder of the repo for instructions in building the mosip code. The output of the build process will be docker images that can be deployed along with configuration.


## mosip deployment

In order to deploy mosip the configuration has to be first updated to point to the mosip environment. Additionally the docker deployment instructions for the kubernetes setup have to point to the correct cluster and the corresponding docker images.

### Configuration setup

