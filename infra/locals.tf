locals {
  project_name         = "event-runner-piba"
  api_gtw_name         = "api-gtw-${local.project_name}"
  stage                = "prd"
  auth_none            = "NONE"
  method_get           = "GET"
  timeout_api          = 29000
  type_integration_api = "HTTP_PROXY"
  http_code_ok         = "200"
  allow_origins        = "'*'"
  retention_log        = 1
  policy_api_gtw_log   = "${local.api_gtw_name}_log_policy"
  role_api_gtw_log     = "${local.api_gtw_name}_log_role"
}