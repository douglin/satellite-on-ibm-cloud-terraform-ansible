# Deploy IBM Cloud Virtual Servers and attach them to an IBM Cloud Satellite location
Terraform to deploy hosts
Ansible to attach the deployed hosts to an IBM Cloud Satellite location

## What this Terraform orchestrates:
1. A VPC
2. Public and private subnets in 3 IBM Cloud availability zones - only the public subnets are used in this code so far
3. Virtual servers labeled "control" and "worker" with profiles and counts specified in variables.tf
4. Two ansible inventory files, one for the "control" hosts and one for the "worker" hosts

## 1. Add your credentials to terrform.tfvars

## 2. Specify variables in variables.tf like the IBM Cloud resource group and attach script for your satellite location
Pre-Req: create an IBM Cloud satellite location and download the attach script

## 3. Setup and Run Terraform
Pre-Req: setup the IBM Cloud terraform plugin, see https://github.com/IBM-Cloud/terraform-provider-ibm

## 4. Run the attach scripts to connect to the IBM Cloud Satellite location
./setup_sat_control_hosts.sh
./setup_sat_worker_hosts.sh

## 5. Wait a minute or so and the hosts will show up in IBM Cloud Satellte

## 6. Use the IBM Cloud GUI or CLI to configure the hosts
