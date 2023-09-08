resource "aws_s3_bucket" "example" {
  bucket = "cloud-topia-images"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}