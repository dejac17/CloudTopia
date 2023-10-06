# Create api
resource "aws_apigatewayv2_api" "http-api" {
  name = "Cloudtopia-Api"
  protocol_type = "HTTP"
}

# Stage for api
resource "aws_apigatewayv2_stage" "lambda-testing" {
  api_id = aws_apigatewayv2_api.http-api.id
  name = "test"
  auto_deploy = true
}

# Integrate gateway with lambda function
resource "aws_apigatewayv2_integration" "lambda" {
  api_id = aws_apigatewayv2_api.http-api.id
  integration_type = "AWS_PROXY"
  description = "Integration with lambda"
  integration_method = "POST"
  integration_uri = aws_lambda_function.test_lambda.invoke_arn
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "lambda-route" {
  api_id = aws_apigatewayv2_api.http-api.id
  route_key = "GET /images"
  target = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

# Gives api gateway permission to invoke lambda
 resource "aws_lambda_permission" "api-gw" {
   statement_id = "AllowExecutionFromAPIGateway"
   action = "lambda:InvokeFunction"
   function_name = aws_lambda_function.test_lambda.function_name
   principal = "apigateway.amazonaws.com"
   source_arn = "${aws_apigatewayv2_api.http-api.execution_arn}/*/*"
 }

 data "archive_file" "lambda3" {
  type        = "zip"
  source_file = "lambda_function2.py"
  output_path = "second_lambda_function.zip"
}

# Create second lambda function
resource "aws_lambda_function" "test_lambda" {
  filename      = "second_lambda_function.zip"
  function_name = "ImageRequestHandler"
  role          = aws_iam_role.iam_for_lambda3.arn
  handler       = "lambda_function2.lambda_handler"

  source_code_hash = data.archive_file.lambda3.output_base64sha256

  runtime = "python3.11"
}

resource "aws_iam_role" "iam_for_lambda3" {
  name               = "iam_for_lambda3"
  assume_role_policy = data.aws_iam_policy_document.assume_role1.json
}

resource "aws_iam_role_policy_attachment" "allow_get-item" {
  policy_arn = aws_iam_policy.get-item.arn
  role       = aws_iam_role.iam_for_lambda3.name
}

resource "aws_iam_policy" "get-item" {
  name        = "Get-Item"
  path        = "/"
  description = "allows lambda to get items from dynamodb"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

data "aws_iam_policy_document" "assume_role1" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}