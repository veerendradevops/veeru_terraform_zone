variable "region" {
    description = "region to create instance"
}

variable "ami" {
description = "image id to launch"
}

variable "key_name"{
description = "keyname"
}

variable "instance_type" {
description = "instancetype to launch"
}

variable "availability_zones" {
description = "Availabilityzones that are going to be used for the subnets"
}

variable "environment_tag" {
description = "defining the environment"
default = "apache"
}