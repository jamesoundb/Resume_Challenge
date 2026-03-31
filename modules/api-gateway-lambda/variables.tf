variable "api_name" {
  description = "Name of the API Gateway REST API"
  type        = string
}

variable "api_description" {
  description = "Description of the API Gateway REST API"
  type        = string
  default     = "API Gateway for Lambda integration"
}

variable "resource_path_part" {
  description = "Path part for the API Gateway resource"
  type        = string
}

variable "http_method" {
  description = "HTTP method for the API Gateway method"
  type        = string
  default     = "GET"
}

variable "authorization" {
  description = "Authorization type for the API Gateway method"
  type        = string
  default     = "NONE"
}

variable "lambda_invoke_arn" {
  description = "Invoke ARN of the Lambda function to integrate with"
  type        = string
}

variable "content_handling" {
  description = "Content handling strategy for the integration"
  type        = string
  default     = "CONVERT_TO_TEXT"
}

variable "stage_name" {
  description = "Name of the deployment stage"
  type        = string
  default     = "prod"
}

variable "enable_cors" {
  description = "Whether to enable CORS for the API"
  type        = bool
  default     = true
}

variable "cors_origin" {
  description = "Allowed origin for CORS"
  type        = string
  default     = "*"
}

variable "cors_methods" {
  description = "Allowed methods for CORS"
  type        = string
  default     = "GET, POST, OPTIONS"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
