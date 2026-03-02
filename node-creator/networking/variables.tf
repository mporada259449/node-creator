variable "cidr_main" {
  description = "The CIDR block for the runners VPC"
  default     = "192.168.0.0/16"
}

variable "cidr_private" {
  description = "The CIDR block for private subnet"
  default     = "192.168.1.0/24"
}

variable "cidr_public" {
  description = "The CIDR block for public subnet"
  default     = "192.168.2.0/24"
}