data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda2"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "photo_processor" {
  filename      = "lambda_function_payload.zip"
  function_name = "PhotoValidationProcess"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.11"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_iam_role_policy_attachment" "allow_get_object" {
  policy_arn = aws_iam_policy.get-object.arn
  role       = aws_iam_role.iam_for_lambda.name
}

resource "aws_iam_policy" "get-object" {
  name        = "Get-Object-Images"
  path        = "/"
  description = "allows lambda to get images from s3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "rekognition:DetectFaces",
          "dynamodb:PutItem",
          "sns:Publish",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

