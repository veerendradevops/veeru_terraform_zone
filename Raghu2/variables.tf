variable "region" {
    description = "region to create instance"
    default = "us-east-1"
}

variable "ami" {
description = "image id to launch"
default = "ami-09d95fab7fff3776c"
}

variable "key_name"{
description = "keyname"
default = "veeru7799"
}

variable "instance_type" {
description = "instancetype to launch"
default = "t2.micro"
}

variable "availability_zones" {
description = "Availabilityzones that are going to be used for the subnets"
default = "us-east-1a"
}

####Module Parameters ####
variable "environment_tag" {
description = "defining the environment"
default = "apache"
}

variable "privatekeypath" {
description = "private pem file"
default = "veeru7799.pem"
}