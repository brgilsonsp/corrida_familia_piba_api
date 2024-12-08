locals {
  project_name         = "event-runner-piba"
  api_gtw_name         = "api-gtw-${local.project_name}"
  auth_none            = "NONE"
  method_get           = "GET"
  timeout_api          = 29000
  type_integration_api = "HTTP_PROXY"
  wiremock_address     = "https://lvwdj.wiremockapi.cloud/v1"
  http_code_ok         = "200"
  allow_origins        = "'*'"
}