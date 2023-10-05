resource "aws_s3_bucket" "photos" {
  bucket = "cloud-topia-images"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# Triggers lambda when something is uploaded to s3
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.photos.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.photo_processor.arn
    events              = ["s3:ObjectCreated:Put"]
  }
}

resource "aws_lambda_permission" "invoke-notification" {
statement_id  = "AllowS3Invoke"
action        = "lambda:InvokeFunction"
function_name = aws_lambda_function.photo_processor.function_name
principal = "s3.amazonaws.com"
source_arn = "arn:aws:s3:::${aws_s3_bucket.photos.id}"
}