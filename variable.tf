variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "Available cidr blocks for public subnets."
  type        = list(string)
  default     = [
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]
}
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  default     = "ami-053b0d53c279acc90"  
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"  
}

