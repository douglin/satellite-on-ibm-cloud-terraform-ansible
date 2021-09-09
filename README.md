# Deploy IBM Cloud Virtual Servers and attach them to an IBM Cloud Satellite location

This repo includes Terraform to deploy hosts, an Ansible playbook, and scripts that execute the Ansible to attach the deployed hosts to an IBM Cloud Satellite location

## 1. Add your credentials to terrform.tfvars

## 2. Specify variables in variables.tf like the IBM Cloud resource group and attach script for your satellite location
```
Pre-Req: create an IBM Cloud satellite location and download the attach script
```

## 3. Setup and Run Terraform
```
Pre-Req: setup Terraform and the IBM Cloud terraform plugin
See https://cloud.ibm.com/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-setup_cli#install_provider
Note that the instructions for the IBM Cloud plugin differ if you are using Terraform 0.13x and newer versus older versions
```
```
# initialize terraform, do this once
terraform init

# useful terraform
# use apply to apply changes, destroy to deprovision all the resources including the VPC
terraform plan
terraform apply
terraform destroy

```
The Terraform orchestrates
1. A VPC
2. Public and private subnets in 3 IBM Cloud availability zones - only the public subnets are used in this code so far
3. Virtual servers labeled "control" and "worker" with profiles and counts specified in variables.tf
4. Two ansible inventory files, one for the "control" hosts and one for the "worker" hosts

## 4. Run the attach scripts to connect to the IBM Cloud Satellite location
```
# either rename the Satellite attach script to "attachHost-Satellite-demo.sh" or
# edit satellite_playbook.yml and replace "attachHost-Satellite-demo.sh" with the name of the script that you want to use

# replace <your SSH key> in the following files with the SSH key, e.g. something like "/Users/myuser/.ssh/id_rsa"
setup_sat_control_hosts.sh
setup_sat_worker_hosts.sh

# run these scripts to attach the hosts
./setup_sat_control_hosts.sh
./setup_sat_worker_hosts.sh
```

## 5. Wait a minute or so and the hosts will show up in IBM Cloud Satellte

## 6. Use the IBM Cloud GUI or CLI to configure the hosts
