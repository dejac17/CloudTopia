# Defines Cloudwatch Log Group
resource "aws_cloudwatch_log_group" "photo-process" {
  name = aws_lambda_function.photo_processor.function_name
  retention_in_days = 30
}

# Gives lambda permission to write to cloudwatch
resource "aws_lambda_permission" "allow-cloudwatch" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.photo_processor.function_name
  principal     = "events.amazonaws.com"
  source_arn = "${aws_cloudwatch_log_group.photo-process.arn}/*/*"
}

resource "aws_iam_role_policy" "logs" {
  name   = "lambda-logs"
  role   = aws_iam_role.iam_for_lambda.name
  policy = jsonencode({
    "Statement": [
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:logs:*:*:*",
      }
    ]
  })
}