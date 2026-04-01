# API Gateway Throttling
# Rate limit: 10 requests/second, burst: 20
resource "aws_api_gateway_method_settings" "api_throttling" {
  rest_api_id = module.api_gateway.api_id
  stage_name  = module.api_gateway.stage_name
  method_path = "*/*"

  settings {
    throttling_rate_limit  = 10
    throttling_burst_limit = 20
  }
}
