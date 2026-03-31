resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_acl" "website_acl" {
  bucket = aws_s3_bucket.website.id
  acl    = var.acl
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
}

resource "aws_s3_object" "website_files" {
  for_each = var.website_files

  bucket       = aws_s3_bucket.website.id
  key          = each.key
  source       = each.value.source
  acl          = var.acl
  content_type = each.value.content_type
  etag         = filemd5(each.value.source)
}
