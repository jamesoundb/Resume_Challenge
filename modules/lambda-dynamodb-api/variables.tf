variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_filename" {
  description = "Path to the Lambda deployment package (zip file)"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "python3.9"
}

variable "timeout" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Lambda function memory size in MB"
  type        = number
  default     = 128
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "enable_dynamodb_access" {
  description = "Whether to grant DynamoDB access to the Lambda function"
  type        = bool
  default     = false
}

variable "dynamodb_table_arns" {
  description = "List of DynamoDB table ARNs to grant access to"
  type        = list(string)
  default     = []
}

variable "additional_policy_statements" {
  description = "Additional IAM policy statements for the Lambda function"
  type        = list(any)
  default     = []
}

variable "allow_api_gateway_invoke" {
  description = "Whether to allow API Gateway to invoke this Lambda function"
  type        = bool
  default     = false
}

variable "api_gateway_execution_arn" {
  description = "Execution ARN of the API Gateway to allow invocation from"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
