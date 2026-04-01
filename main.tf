# DynamoDB Tables
module "dynamodb_tables" {
  source  = "app.terraform.io/Jamesoundb/dynamodb-tables/aws"
  version = "1.0.2"

  tables = {
    visitors = {
      name         = "Visitors"
      billing_mode = "PAY_PER_REQUEST"
      hash_key     = "visitor"
      attributes = [
        {
          name = "visitor"
          type = "N"
        }
      ]
    }

    statefile_lock = {
      name         = "Statefile_lock"
      billing_mode = "PAY_PER_REQUEST"
      hash_key     = "LockID"
      attributes = [
        {
          name = "LockID"
          type = "S"
        }
      ]
    }
  }

  tags = {
    Project     = "CloudResume"
    Environment = "production"
  }
}

# S3 Static Website
module "s3_website" {
  source  = "app.terraform.io/Jamesoundb/s3-static-website/aws"
  version = "1.0.0"

  bucket_name    = var.bucket_name
  index_document = "index.html"
  error_document = "error.html"

  tags = {
    Project     = "CloudResume"
    Environment = "production"
  }
}

# Lambda Function
module "lambda_function" {
  source  = "app.terraform.io/Jamesoundb/lambda-dynamodb-api/aws"
  version = "1.0.0"

  function_name   = "lambda_function"
  lambda_filename = "lambda/lambda_function.zip"
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.8"

  enable_dynamodb_access = true
  dynamodb_table_arns    = [module.dynamodb_tables.table_arns["visitors"]]

  allow_api_gateway_invoke  = true
  api_gateway_execution_arn = "${module.api_gateway.api_execution_arn}/*"

  environment_variables = {
    TABLE_NAME = "Visitors"
  }

  tags = {
    Project     = "CloudResume"
    Environment = "production"
  }
}

# API Gateway
module "api_gateway" {
  source  = "app.terraform.io/Jamesoundb/api-gateway-lambda/aws"
  version = "1.0.0"

  api_name           = "MyAPI"
  api_description    = "CORS-enabled methods."
  resource_path_part = "visitorcount"
  http_method        = "GET"
  lambda_invoke_arn  = module.lambda_function.invoke_arn
  stage_name         = "MyAPI"

  enable_cors  = true
  cors_origin  = "*"
  cors_methods = "GET, POST"

  tags = {
    Project     = "CloudResume"
    Environment = "production"
  }
}

# CloudFront + Route53
module "cloudfront_website" {
  source  = "app.terraform.io/Jamesoundb/cloudfront-s3-website/aws"
  version = "1.0.2"

  domain_name                    = var.root_domain_name
  subject_alternative_names      = ["*.${var.root_domain_name}"]
  s3_bucket_regional_domain_name = module.s3_website.bucket_regional_domain_name
  s3_origin_id                   = "jameswurbel"
  oai_comment                    = "mybucketid"
  cloudfront_comment             = "index"

  aliases             = [var.root_domain_name, var.www_domain_name]
  default_root_object = "index.html"
  price_class         = "PriceClass_200"

  minimum_protocol_version = "TLSv1.2_2021"
  evaluate_target_health   = true

  ordered_cache_behaviors = [
    {
      path_pattern           = "/content/immutable/*"
      allowed_methods        = ["GET", "HEAD", "OPTIONS"]
      cached_methods         = ["GET", "HEAD", "OPTIONS"]
      viewer_protocol_policy = "redirect-to-https"
      min_ttl                = 0
      default_ttl            = 86400
      max_ttl                = 31536000
      compress               = true
      headers                = ["Origin"]
    },
    {
      path_pattern           = "/content/*"
      allowed_methods        = ["GET", "HEAD", "OPTIONS"]
      cached_methods         = ["GET", "HEAD"]
      viewer_protocol_policy = "redirect-to-https"
      min_ttl                = 0
      default_ttl            = 3600
      max_ttl                = 86400
      compress               = true
    }
  ]

  geo_restriction_type      = "blacklist"
  geo_restriction_locations = ["CN", "RU", "IR", "KP", "SY", "CU", "BY"]

  enable_waf_rate_limiting = true
  waf_rate_limit          = 2000

  tags = {
    Environment = "production"
  }
}
