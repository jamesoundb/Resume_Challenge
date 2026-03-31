# API Gateway Lambda Integration Module

This module creates an AWS API Gateway REST API with Lambda integration and CORS support.

## Features

- Creates a REST API with a single resource and method
- Lambda function integration
- CORS configuration
- Automatic deployment and staging
- Customizable HTTP methods and authorization

## Usage

```hcl
module "api_gateway" {
  source = "./modules/api-gateway-lambda"

  api_name          = "MyAPI"
  api_description   = "API for visitor counter"
  resource_path_part = "visitorcount"
  http_method       = "GET"
  lambda_invoke_arn = module.lambda.invoke_arn
  stage_name        = "prod"

  enable_cors  = true
  cors_origin  = "*"
  cors_methods = "GET, POST, OPTIONS"

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
| api_name | Name of the REST API | `string` | n/a | yes |
| api_description | Description of the API | `string` | `"API Gateway for Lambda integration"` | no |
| resource_path_part | Path part for the resource | `string` | n/a | yes |
| http_method | HTTP method | `string` | `"GET"` | no |
| authorization | Authorization type | `string` | `"NONE"` | no |
| lambda_invoke_arn | Lambda invoke ARN | `string` | n/a | yes |
| content_handling | Content handling strategy | `string` | `"CONVERT_TO_TEXT"` | no |
| stage_name | Deployment stage name | `string` | `"prod"` | no |
| enable_cors | Enable CORS | `bool` | `true` | no |
| cors_origin | CORS allowed origin | `string` | `"*"` | no |
| cors_methods | CORS allowed methods | `string` | `"GET, POST, OPTIONS"` | no |
| tags | Tags to apply | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| api_id | ID of the REST API |
| api_arn | ARN of the REST API |
| api_execution_arn | Execution ARN for Lambda permissions |
| invoke_url | Invoke URL for the API |
| stage_name | Name of the deployment stage |
| resource_path | Full path of the API resource |
