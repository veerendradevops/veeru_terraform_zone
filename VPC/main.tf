module "vpc" {
    source ="../modules/vpc"
    cidr_block = "${var.cidr_block}"
    availability_zones = "${var.availability_zones}"
backend "s3" {
 encrypt = true
 bucket = "backendvk"
 dynamodb_table = "tfdynamo-state-lock"
 region = "us-east-1"
 key = "terraform.tfstate"
 }
}
}