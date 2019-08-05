#global parameters like accesskey, secretket, region and availabilityzone etc

variable "region" {
description = "Region"
}

variable "availability_zones" {
description = "Availabilty Zones that are going to used for the subnets"
}

variable "aws_access_key" {
type = "string"
}

variable "aws_secret_key" {
type = "string"
}

#EC2 INSTANCE PARAMETERS
variable "ami" {
description = "image id to launch"
}

variable "key_name" {
description = "keyname"
}

variable "instance_type" {
description = "instancetype to launch"
}
