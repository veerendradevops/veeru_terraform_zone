variable "availability_zones" {
    type = "list"
    default = ["us-east-1a","us-east-1b"]
}

variable "cidr_block" {
    default = "10.0.0.0/8"
}
