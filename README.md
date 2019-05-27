# MOSIP Infra

## Introduction

MOSIP is Modular Open Source Identity Platform, read and learn more about it in the extensive [documentation](https://github.com/mosip-open/Documentation). The seed contribution to MOSIP is still work in progress, consider this repo as an early preview for now. For now, we aim to give the community a sense of early direction with this preview. 

The issue list is open, but we will not act upon the issues till a formal release is behind us.

MOSIP Infra is central location for infrastructure code and suggested infrastructure management practices for all MOSIP subsystems.  Much of the data center operation in MOSIP is driven by this configuration and code.

## Infrastructure as code
This code base and related documentation is for community members tinkering with setup, operations and scaling of the system. It relies heavily on Docker and Kubernetes.

To bring up a simple Azure deployment, follow these [instructions](https://github.com/mosip-open/mosip-prereg-client/blob/master/Getting-started-ui.md).

## Azure cloud dependence
This code currently runs on Microsoft Azure Cloud. Efforts are on to bring the infrastructure up on simple virtual machine and file systems. Stay tuned 