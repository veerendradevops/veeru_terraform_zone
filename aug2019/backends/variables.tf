
variable "ami" {
default =   "ami-07d0cf3af28718ef8"
}
variable "key_name" {
  default = "vksonata"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "region" {
default = "us-east-1"
}

variable "availability_zones" {
 default = "us-east-1a"
}

variable "aws_access_key" {
type = "string"
}

variable "aws_secret_key" {
type = "string"
}



