resource "aws_s3_bucket" "statefile" {
  bucket = var.bucket_name_statefile
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_acl" "statefile" {
  bucket = aws_s3_bucket.statefile.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "statefile_versioning" {
  bucket = aws_s3_bucket.statefile.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "statefile_encryption" {
  depends_on = [
    aws_s3_bucket.statefile
  ]
  bucket = aws_s3_bucket.statefile.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_iam_role" "iam_for_s3_backend" {
  name = "iam_for_s3_backend"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "statefile_backend" {
  name        = "statefile_backend_storage"
  path        = "/"
  description = "IAM policy for statefile storage to s3 backend"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::jameswurbel.com-statefile-storage"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
      "Resource": "arn:aws:s3:::jameswurbel.com-statefile-storage/terraform.tfstate"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "statefile" {
  role       = aws_iam_role.iam_for_s3_backend.name
  policy_arn = aws_iam_policy.statefile_backend.arn
}
