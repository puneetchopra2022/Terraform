variable "awsregion" {
  description = "awsregion"
  type        = string
  default     = ""
}
variable "bucketname" {
  description = "S3backendBucketname"
  type        = string
  default     = ""
}

variable "vpcname" {
  description = "vpcname"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "cidr"
  type        = string
  default     = ""
}

variable "az" {
  description = "Provide list of Availability zone for VPC"
  type        = list(any)
  default     = ["", "", ""]


}

variable "private" {
  description = "Provide list of Private IP for Subnet"
  type        = list(any)
  default     = ["", "", ""]


}


variable "ekclustername" {
  description = "Provide eksclustername"
  type        = string
  default     = ""
}


variable "clusterversion" {
  description = "Provide eks cluster version"
  type        = string
  default     = ""
}


variable "authentication_mode" {
  description = "The authentication mode for the cluster. Valid values are `CONFIG_MAP`, `API` or `API_AND_CONFIG_MAP`"
  type        = string
  default     = "API_AND_CONFIG_MAP"
}


variable "instancetype" {
  description = "eksinstanceype"
  type        = string
  default     = ""
}
