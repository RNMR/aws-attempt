data "archive_file" "main" {
  type        = "zip"
  source_file = "index.js"
  output_path = "main.zip"
}

data "aws_iam_policy_document" "main" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}