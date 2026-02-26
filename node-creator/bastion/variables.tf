variable "bastion_type" {
    description = "The type of the bastion host. Valid values are 't2.micro', 't3.micro', etc."
    type        = string
    default     = "t2.micro"
}

variable "bastion_subnet"{
    description = "Subnet id for bastion host"
    type = string 
}

variable "bastion_vpc" {
    description = "VPC id for bastion host"
    type = string
}

variable "bastion_key" {
    description = "Bastion ssh key"
    type = string
}