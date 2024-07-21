variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.2.0/24"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-01fccab91b456acc2"  # Amazon Linux 2 AMI ID 
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name"
  default     = "terraform"
}
