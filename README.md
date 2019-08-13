# OpenShift Container Platform Enterprise Installer Single
The OpenShift Container Platform Enterprise Installer Single Terraform template and inline modules will provision 1 virtual machines, install prerequisites and install the OpenShift Container Platform within you vmWare Hypervisor enviroment.

This template will install and configure the OpenShift Container Platform in a Single Node topology.

The components of a OpenShift Container Platform include:

- Master Nodes (All in 1 Node)
- Etcd Nodes (All in 1 Node)
- Compute Nodes (All in 1 Node)
- Infrastructure Node (All in 1 Node)

## OpenShift Container Platform Versions

| OpenShift Version | GitTag Reference|
|------|:-------------:|
| 3.11 | 3.11 |

## System Requirements

### Hardware requirements

OpenShift Container Platform must meet the following requirements:
<https://docs.openshift.com/container-platform/3.11/install/prerequisites.html#hardware>

This template will setup the following hardware minimum requirements:

| Node Type | CPU Cores | Memory (mb) | Disk 1 | Disk 2 | Number of hosts |
|------|:-------------:|:----:|:-----:|:-----:|:-----:|
| Single Node | 4 | 16384 | 100 | n/a | 1 |

For minimum directory space requirements, i.e. /var/ or /usr/local/bin/, 
please refer to https://docs.openshift.com/container-platform/3.11/install/prerequisites.html#hardware

### Supported operating systems and platforms

The following operating systems and platforms are supported.

***Red Hat Enterprise Linux (RHEL) 7.4 or later***

- VMware Tools must be enabled in the image for VMWare template.
- Sudo User and password must exist and be allowed for use.
- SELinux must be enabled. 
  Steps: https://access.redhat.com/documentation/en-us/red_hat_gluster_storage/3.1/html/installation_guide/chap-enabling_selinux
- Minimum recommended kernel version is '3.10.0-862.14.4'
