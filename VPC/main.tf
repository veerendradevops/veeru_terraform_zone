module "vpc" {
    source ="../modules/vpc"
    cidr_block = "${var.cidr_block}"
    availability_zone = "${var.availability_zones}"

}