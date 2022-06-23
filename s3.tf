resource "aws_s3_bucket" "jameswurbel" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  bucket = aws_s3_bucket.jameswurbel.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "jameswurbel" {
  bucket = aws_s3_bucket.jameswurbel.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "resume" {
  bucket       = aws_s3_bucket.jameswurbel.id
  key          = var.s3_resume_key
  source       = var.s3_resume_source
  acl          = var.acl
  content_type = "text/html"
}

resource "aws_s3_object" "apifetch_jameswurbel" {
  bucket = aws_s3_bucket.jameswurbel.id
  key    = var.s3_javascript_key
  source = var.s3_javascript_source
  acl    = var.acl
}