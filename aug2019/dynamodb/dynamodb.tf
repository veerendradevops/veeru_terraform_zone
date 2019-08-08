#create a dynamodb table for locking the statefile
provider "aws" {
  region = "us-east-1"
}
resource "aws_dynamodb_table" "dynamodb-tf-state-lock" {
  name = "tfdynamo-state-lock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
  attribute {
      name = "LockID"
      type = "S"
  }
  tags = {
      Name = "DynamoDB Terraform Statelock Table"
  }
}

