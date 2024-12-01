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
  handler       = "index.main"

  source_code_hash = data.archive_file.main.output_base64sha256

  runtime = "nodejs18.x"

  environment {
    variables = var.environment
  }

  tags = {
    name = var.name
  }
}