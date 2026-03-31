# S3 Static Website Module

This module creates an S3 bucket configured for static website hosting.

## Features

- Creates an S3 bucket with website hosting enabled
- Configures bucket ACL for public read access
- Supports custom index and error documents
- Allows uploading multiple website files

## Usage

```hcl
module "static_website" {
  source = "./modules/s3-static-website"

  bucket_name    = "www.example.com"
  index_document = "index.html"
  error_document = "error.html"

  website_files = {
    "index.html" = {
      source       = "/path/to/index.html"
      content_type = "text/html"
    }
    "script.js" = {
      source       = "/path/to/script.js"
      content_type = "application/javascript"
    }
  }

  tags = {
    Environment = "production"
    Project     = "my-website"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_name | Name of the S3 bucket | `string` | n/a | yes |
| acl | ACL for the bucket and objects | `string` | `"public-read"` | no |
| index_document | Index document for the website | `string` | `"index.html"` | no |
| error_document | Error document for the website | `string` | `"error.html"` | no |
| website_files | Map of files to upload | `map(object)` | `{}` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The ID of the S3 bucket |
| bucket_arn | The ARN of the S3 bucket |
| bucket_regional_domain_name | Regional domain name of the bucket |
| website_endpoint | The website endpoint |
| website_domain | The website domain |
