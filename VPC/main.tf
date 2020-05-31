module "vpc" {
    source ="../modules/vpc"
    cidr_block = "${var.cidr_block}"
    availability_zones = "${var.availability_zones}"

}