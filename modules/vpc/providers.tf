provider "aws" {
    region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::911348902258:role/vkterraform_role"
    profile      = "default"
    #session_name = "SESSION_NAME"
    #external_id  = "EXTERNAL_ID"
  }
}
