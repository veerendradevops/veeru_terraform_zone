provider "aws" {
  region = "us-east-1"
}
#terraform statefile setup
# create an s3 bucket to store statefile in resource
resource "aws_s3_bucket" "backendvk" {
    bucket = "s3backendvk"
    versioning{
        enabled = true
    }
    lifecycle {
        prevent_destroy = true
    }
    
    tags = {
        Name = "S3Remote Terraform state store"
    }
}


