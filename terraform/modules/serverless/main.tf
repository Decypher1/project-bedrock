resource "aws_s3_bucket" "assets" {
  bucket = var.bucket_name

  tags = {
    Project = var.project_tag
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "bedrock-asset-processor-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "asset_processor" {

  function_name = "bedrock-asset-processor"

  filename         = "${path.root}/lambda/lambda.zip"
  source_code_hash = filebase64sha256("${path.root}/lambda/lambda.zip")

  runtime = "python3.12"
  handler = "lambda_function.lambda_handler"

  role = aws_iam_role.lambda_role.arn
}

resource "aws_lambda_permission" "allow_s3" {

  statement_id = "AllowExecutionFromS3"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.asset_processor.function_name

  principal = "s3.amazonaws.com"

  source_arn = aws_s3_bucket.assets.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {

  bucket = aws_s3_bucket.assets.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.asset_processor.arn

    events = [
      "s3:ObjectCreated:*"
    ]
  }

  depends_on = [
    aws_lambda_permission.allow_s3
  ]
}