provider "aws" {
    region = "us-east-1"
  assume_role {
    shared_credentials_file = "/home/ubuntu/.aws/credentails"
      profile                 = "default"
    #role_arn     = "arn:aws:iam::<account>:role/vkssmrole"
    #session_name = "SESSION_NAME"
    #external_id  = "EXTERNAL_ID"
  }
}
