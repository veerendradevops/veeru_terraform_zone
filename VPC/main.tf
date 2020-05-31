/*
module s3_backend {
  source                      = "youngfeldt/backend-s3/aws"
  version                     = ">= 1.0.0"
  backend_s3_bucket           = "backendvk"
  backend_dynamodb_lock_table = "tfdynamo-state-lock"
  create_dynamodb_lock_table  = true
  create_s3_bucket            = true
  s3_key                      = "terraform.tfstate"
}
*/

module "vpc" {
    source ="../modules/vpc"
    cidr_block = "${var.cidr_block}"
    availability_zones = "${var.availability_zones}"

}
terraform {
    backend "s3"{
        bucket = "backendvk"
        key = "terraform.tfstate"
        dynamodb_table = "tfdynamo-state-lock"
        region = "us-east-1"
        encrypt = false
    }
}