resource "aws_sns_topic" "valid_results" {
  name            = "ValidationResult"
}

resource "aws_sns_topic_subscription" "valid_results_target" {
  topic_arn = aws_sns_topic.valid_results.arn
  protocol  = "email-json"
  endpoint  = "dejclark@cisco.com"
}