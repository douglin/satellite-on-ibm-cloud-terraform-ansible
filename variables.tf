variable "per_zone_worker_count" {
  type = number
  default = 2
}

variable "per_zone_control_host_count" {
  type = number
  default = 1
}

variable "resource_group" {
  type = string
  default = "Demos-shared"
  }

variable "default_tags" {
  type = list(string)
  default = ["satellite-demo"]
  }

variable "satellite_attach_file" {
  type = string
  default = "attachHost-Satellite-demo.sh"
  }

variable "default_az" {
  type = string
  default = "us-south"
}

variable "root_name" {
  type = string
  default = "satellite-demo"
}

variable "control_host_profile" {
  type = string
  default = "bx2-4x16"
}

variable "worker_host_profile" {
  type = string
  default = "bx2-4x16"
}

variable "prefixes" {
  type = list
  default = ["10.247.0.0","10.247.1.0","10.247.2.0","10.247.3.0","10.247.4.0","10.247.5.0"]
}

variable "iaas_classic_username" {}
variable "iaas_classic_api_key" {}
variable "ibmcloud_api_key" {}
