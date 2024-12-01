resource "aws_iam_role" "main" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.main.json
}

resource "aws_lambda_function" "main" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "main.zip"
  function_name = var.name
  role          = aws_iam_role.main.arn
  handler       = "main.handler"

  source_code_hash = data.archive_file.main.output_base64sha256

  runtime = "nodejs18.x"

  environment {
    variables = var.environment
  }

  ephemeral_storage {
    size = 512
  }

  memory_size = 128

  tags = {
    name = var.name
  }
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/lambda/${var.name}"
  retention_in_days = 14
}

resource "aws_iam_policy" "logging" {
  name        = var.name
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.logging.json
}

resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.logging.arn
}