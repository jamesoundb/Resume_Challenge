resource "aws_dynamodb_table" "visitors" {
  name         = "Visitors"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "visitor"

  attribute {
    name = "visitor"
    type = "N"
  }
}

resource "aws_dynamodb_table" "statefile_lock" {
  name         = "Statefile_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_iam_role" "iam_for_dynamodb_state_lock" {
  name = "iam_for_dynamodb_state_lock"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "dynamodb.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "dynamodb_state_lock" {
  name        = "State_lock_file_storage"
  path        = "/"
  description = "IAM policy for state lock storage to dynamodb"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "arn:aws:dynamodb:*:*:Statefile_lock/statefile_lock"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "dynamodb_state_lock" {
  role       = aws_iam_role.iam_for_dynamodb_state_lock.name
  policy_arn = aws_iam_policy.dynamodb_state_lock.arn
}