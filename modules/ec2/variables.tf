variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default = "ami-01fccab91b456acc2"
}

variable "instance_type" {
  description = "Instance type"
  default = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "key_name" {
  description = "Key pair name"
  default = "terraform"
}
