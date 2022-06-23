# aws_s3_bucket outputs:
output "bucket_id" {
  value = aws_s3_bucket.jameswurbel.id
}

output "bucket_arn" {
  value = aws_s3_bucket.jameswurbel.arn
}

output "bucket_domain_name" {
  value = aws_s3_bucket.jameswurbel.bucket_domain_name
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.jameswurbel.bucket_regional_domain_name
}

output "bucket_hosted_zone_id" {
  value = aws_s3_bucket.jameswurbel.hosted_zone_id
}

output "bucket_region" {
  value = aws_s3_bucket.jameswurbel.region
}

output "bucket_website_endpoint" {
  value = aws_s3_bucket.jameswurbel.website_endpoint
}

output "bucket_website_domain" {
  value = aws_s3_bucket.jameswurbel.website_domain
}

# aws_s3_bucket_acl outputs:
output "bucket_acl" {
  value = aws_s3_bucket_acl.bucket-acl.id
}

# aws_s3_bucket_website_configuration outputs:
output "bucket_website_configuration_id" {
  description = "The name of the bucket."
  value       = aws_s3_bucket_website_configuration.jameswurbel.id
}

output "bucket_website_configuration_domain" {
  description = "The bucket website domain."
  value       = aws_s3_bucket_website_configuration.jameswurbel.website_domain
}

output "bucket_website_configuration_endpoint" {
  description = "The bucket website endpoint."
  value       = aws_s3_bucket_website_configuration.jameswurbel.website_endpoint
}

# aws_s3_object outputs:
output "bucket_object_id" {
  value = aws_s3_object.resume.id
}

output "bucket_of_object" {
  value = aws_s3_object.resume.bucket
}

output "bucket_object_source" {
  value = aws_s3_object.resume.source
}

# aws_acm_certificate outputs:
output "acm_id" {
  value = aws_acm_certificate.certificate.id
}

output "acm_arn" {
  value = aws_acm_certificate.certificate.arn
}

output "acm_domain_name" {
  value = aws_acm_certificate.certificate.domain_name
}

output "acm_domain_validation_options" {
  value = aws_acm_certificate.certificate.domain_validation_options
}

output "acm_status" {
  value = aws_acm_certificate.certificate.status
}

# aws_cloudfront_origin_access_identity outputs:
output "cloudfront_origin_access_identity_id" {
  value = aws_cloudfront_origin_access_identity.jameswurbel.id
}

output "cloudfront_origin_access_identity_path" {
  value = aws_cloudfront_origin_access_identity.jameswurbel.cloudfront_access_identity_path
}

output "cloudfront_origin_access_identity_s3_canonical_user_id" {
  value = aws_cloudfront_origin_access_identity.jameswurbel.s3_canonical_user_id
}

# aws_cloudfront_distribution outputs:
output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.s3_distribution.id
}

output "cloudfront_distribution_arn" {
  value = aws_cloudfront_distribution.s3_distribution.arn
}

output "cloudfront_distribution_status" {
  value = aws_cloudfront_distribution.s3_distribution.status
}

output "cloudfront_distribution_enabled" {
  value = aws_cloudfront_distribution.s3_distribution.enabled
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
}

#aws_dynamodb_table outputs:
output "aws_dynamodb_table_id" {
  value = aws_dynamodb_table.visitors.id
}

output "aws_dynamodb_table_name" {
  value = aws_dynamodb_table.visitors.name
}

output "aws_dynamodb_table_hash_key" {
  value = aws_dynamodb_table.visitors.hash_key
}

output "aws_dynamodb_table_range_key" {
  value = aws_dynamodb_table.visitors.range_key
}

output "aws_dynamodb_table_arn" {
  value = aws_dynamodb_table.visitors.arn
}

#aws_api_gateway_rest_api_cors_api
output "aws_api_gateway_rest_api_cors_api_id" {
  value = aws_api_gateway_rest_api.cors_api.id
}

output "aws_api_gateway_rest_api_cors_api_root_resource_id" {
  value = aws_api_gateway_rest_api.cors_api.root_resource_id
}

output "aws_api_gateway_rest_api_cors_api_execution_arn" {
  value = aws_api_gateway_rest_api.cors_api.execution_arn
}

output "aws_api_gateway_rest_api_cors_api_arn" {
  value = aws_api_gateway_rest_api.cors_api.arn
}

#aws_api_gateway_resource_cors_resource
output "aws_api_gateway_resource_cors_resource_id" {
  value = aws_api_gateway_resource.cors_resource.id
}

output "aws_api_gateway_resource_cors_resource_path" {
  value = aws_api_gateway_resource.cors_resource.path
}

#aws_api_gateway_method_options_method
output "aws_api_gateway_method_options_method_rest_api_id" {
  value = aws_api_gateway_method.options_method.rest_api_id
}

output "aws_api_gateway_method_options_method_resource_id" {
  value = aws_api_gateway_method.options_method.resource_id
}

#aws_api_gateway_method_response_options_200
output "aws_api_gateway_method_response_options_200_rest_api_id" {
  value = aws_api_gateway_method_response.options_200.rest_api_id
}

output "aws_api_gateway_method_response_options_200_resource_id" {
  value = aws_api_gateway_method_response.options_200.resource_id
}

#aws_api_gateway_integration_options_integration
output "aws_api_gateway_integration_options_integration_rest_api_id" {
  value = aws_api_gateway_integration.options_integration.rest_api_id
}

output "aws_api_gateway_integration_options_integration_resource_id" {
  value = aws_api_gateway_integration.options_integration.resource_id
}

output "aws_api_gateway_integration_options_integration_type" {
  value = aws_api_gateway_integration.options_integration.type
}

output "aws_api_gateway_integration_options_integration_uri" {
  value = aws_api_gateway_integration.options_integration.uri
}

#aws_api_gateway_integration_response_options_integration_response
output "aws_api_gateway_integration_response_options_integration_response_rest_api_id" {
  value = aws_api_gateway_integration_response.options_integration_response.rest_api_id
}

output "aws_api_gateway_integration_response_options_integration_response_resource_id" {
  value = aws_api_gateway_integration_response.options_integration_response.resource_id
}

#aws_api_gateway_deployment_deployment
output "aws_api_gateway_deployment_deployment_id" {
  value = aws_api_gateway_deployment.deployment.id
}

output "aws_api_gateway_deployment_deployment_invoke_url" {
  value = aws_api_gateway_deployment.deployment.invoke_url
}

output "aws_api_gateway_deployment_deployment_execution_arn" {
  value = aws_api_gateway_deployment.deployment.execution_arn
}

#aws_lambda_function_lambda
output "aws_lambda_function_lambda_arn" {
  value = aws_lambda_function.lambda.arn
}

output "aws_lambda_function_lambda_invoke_arn" {
  value = aws_lambda_function.lambda.invoke_arn
}

output "aws_lambda_function_lambda_id" {
  value = aws_lambda_function.lambda.id
}

#aws_lambda_permission_lambda_permission
output "aws_lambda_permission_lambda_permission_id" {
  value = aws_lambda_permission.lambda_permission.id
}

output "aws_lambda_permission_lambda_permission_source_arn" {
  value = aws_lambda_permission.lambda_permission.source_arn
}

#aws_iam_role_iam_for_lambda
output "aws_iam_role_iam_for_lambda_arn" {
  value = aws_iam_role.iam_for_lambda.arn
}

output "aws_iam_role_iam_for_lambda_id" {
  value = aws_iam_role.iam_for_lambda.id
}

output "aws_iam_role_iam_for_lambda_name" {
  value = aws_iam_role.iam_for_lambda.name
}

output "aws_iam_role_iam_for_lambda_unique_id" {
  value = aws_iam_role.iam_for_lambda.unique_id
}

#aws_iam_policy_lambda_function
output "aws_iam_policy_lambda_function_id" {
  value = aws_iam_policy.lambda_function.id
}

output "aws_iam_policy_lambda_function_name" {
  value = aws_iam_policy.lambda_function.name
}

output "aws_iam_policy_lambda_function_policy" {
  value = aws_iam_policy.lambda_function.policy
}

output "aws_iam_policy_lambda_function_policy_id" {
  value = aws_iam_policy.lambda_function.policy_id
}

output "aws_iam_policy_lambda_function_arn" {
  value = aws_iam_policy.lambda_function.arn
}