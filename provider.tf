#---------------------------------------------------------
## IBM Cloud provider configuration file
#---------------------------------------------------------

provider "ibm" {
    generation = 2
    region                = var.default_az
    iaas_classic_username = var.iaas_classic_username
    iaas_classic_api_key  = var.iaas_classic_api_key
    ibmcloud_api_key      = var.ibmcloud_api_key
}
