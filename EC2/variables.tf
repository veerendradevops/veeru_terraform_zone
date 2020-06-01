variable "region" {
description = "Region"
default = "us-east-1"
}

variable "privatekeypath" {
description = "private pem file"
default = "veeru7799.pem"
}

locals {
  insta_id        = "module.ec2.aws_instce.id"
}

variable "instance_id" {
    default = local.insta_id
}


/*
#global parameters like accesskey, secretket, region and availabilityzone etc

variable "region" {
description = "Region"
default = "us-east-1"
}

variable "availability_zones" {
description = "Availabilty Zones that are going to used for the subnets"
default = "us-east-1a"
}

#EC2 INSTANCE PARAMETERS
variable "ami" {
description = "image id to launch"
default = "ami-09d95fab7fff3776c"
}

variable "key_name" {
description = "keyname"
default = "veeru7799"
}

variable "instance_type" {
description = "instancetype to launch"
default = "t2.micro"
}

*/