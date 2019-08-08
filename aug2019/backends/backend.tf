provider "aws" {

    region ="us-east-1"
}
terraform {
    backend "s3" {
        encrypt = true
        bucket = "backendvk"
        dynamodb_table = "dynamodb-tf-state-lock"
        region = "us-east-1"
        key="terraform.tfstate"
    }

}
module "ec2" {
  source = "../terraform/modules/ec2"
  ami = "ami-07d0cf3af28718ef8"
instance_type = "t2.micro"
key_name = "vksonata"
availability_zones = "us-east-1a"
  
}
