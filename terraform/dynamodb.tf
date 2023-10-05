resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "ValidationRequests"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "FileName"


  attribute {
    name = "FileName"
    type = "S"
  }

}