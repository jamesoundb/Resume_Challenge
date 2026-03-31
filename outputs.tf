# DynamoDB Outputs
output "dynamodb_table_arns" {
  value = module.dynamodb_tables.table_arns
}

output "dynamodb_table_ids" {
  value = module.dynamodb_tables.table_ids
}

# S3 Website Outputs
output "bucket_id" {
  value = module.s3_website.bucket_id
}

output "bucket_arn" {
  value = module.s3_website.bucket_arn
}

output "website_endpoint" {
  value = module.s3_website.website_endpoint
}

# Lambda Outputs
output "lambda_function_arn" {
  value = module.lambda_function.function_arn
}

output "lambda_invoke_arn" {
  value = module.lambda_function.invoke_arn
}

# API Gateway Outputs
output "api_gateway_id" {
  value = module.api_gateway.api_id
}

output "api_gateway_invoke_url" {
  value = module.api_gateway.invoke_url
}

output "api_gateway_execution_arn" {
  value = module.api_gateway.api_execution_arn
}

# CloudFront Outputs
output "cloudfront_distribution_id" {
  value = module.cloudfront_website.cloudfront_distribution_id
}

output "cloudfront_domain_name" {
  value = module.cloudfront_website.cloudfront_domain_name
}

output "certificate_arn" {
  value = module.cloudfront_website.certificate_arn
}

output "website_url" {
  value = module.cloudfront_website.website_url
}
