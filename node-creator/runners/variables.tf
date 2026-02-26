variable "runner_type" {
    description = "The type of the bastion host. Valid values are 't2.micro', 't3.micro', etc."
    type        = string
    default     = "t2.micro"
}

variable "runner_subnet"{
    description = "Subnet id for bastion host"
    type = string 
}

variable "runner_vpc" {
    description = "VPC id for bastion host"
    type = string
}

variable "bastion_ip" {
  description = "IP number of bastion host"
  type=string
}

variable "ssh_key_name" {
    description = "Key name for runners host taken form bastion module"
    type = string
}

variable "runners_count"{
    description = "Numbers of instances to create"
    type = number
}