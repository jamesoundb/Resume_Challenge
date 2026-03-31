output "api_id" {
  description = "ID of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.api.id
}

output "api_arn" {
  description = "ARN of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.api.arn
}

output "api_execution_arn" {
  description = "Execution ARN of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.api.execution_arn
}

output "invoke_url" {
  description = "Invoke URL for the API Gateway stage"
  value       = aws_api_gateway_stage.stage.invoke_url
}

output "stage_name" {
  description = "Name of the deployment stage"
  value       = aws_api_gateway_stage.stage.stage_name
}

output "resource_path" {
  description = "Full path of the API resource"
  value       = "/${var.resource_path_part}"
}
