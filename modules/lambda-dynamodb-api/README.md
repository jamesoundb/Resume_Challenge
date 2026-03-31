# Lambda Function with DynamoDB Access Module

This module creates an AWS Lambda function with optional DynamoDB access and API Gateway integration.

## Features

- Creates a Lambda function from a deployment package
- Configures IAM role and policies
- Optional DynamoDB table access
- Optional API Gateway invocation permissions
- CloudWatch Logs integration
- Customizable environment variables

## Usage

```hcl
module "lambda_function" {
  source = "./modules/lambda-dynamodb-api"

  function_name    = "my-api-function"
  lambda_filename  = "lambda/function.zip"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  timeout          = 30
  memory_size      = 256

  environment_variables = {
    TABLE_NAME = "my-dynamodb-table"
  }

  enable_dynamodb_access = true
  dynamodb_table_arns    = [aws_dynamodb_table.my_table.arn]

  allow_api_gateway_invoke   = true
  api_gateway_execution_arn  = "${aws_api_gateway_rest_api.api.execution_arn}/*"

  tags = {
    Environment = "production"
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
| function_name | Name of the Lambda function | `string` | n/a | yes |
| lambda_filename | Path to deployment package | `string` | n/a | yes |
| handler | Lambda function handler | `string` | `"lambda_function.lambda_handler"` | no |
| runtime | Lambda runtime | `string` | `"python3.9"` | no |
| timeout | Function timeout in seconds | `number` | `30` | no |
| memory_size | Memory size in MB | `number` | `128` | no |
| environment_variables | Environment variables | `map(string)` | `{}` | no |
| enable_dynamodb_access | Grant DynamoDB access | `bool` | `false` | no |
| dynamodb_table_arns | DynamoDB table ARNs | `list(string)` | `[]` | no |
| allow_api_gateway_invoke | Allow API Gateway invocation | `bool` | `false` | no |
| api_gateway_execution_arn | API Gateway execution ARN | `string` | `""` | no |
| tags | Tags to apply | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| function_name | Name of the Lambda function |
| function_arn | ARN of the Lambda function |
| invoke_arn | Invoke ARN for API Gateway |
| role_arn | ARN of the IAM role |
| role_name | Name of the IAM role |
