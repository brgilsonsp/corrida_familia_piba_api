resource "aws_api_gateway_rest_api" "api_gtw_rest" {
  name        = local.api_gtw_name
  description = "API RESTful para gestão de eventos esportivos de corrida de rua da PIBA"
  tags = {
    name    = local.api_gtw_name
    project = local.project_name
  }
}

resource "aws_api_gateway_deployment" "api_gtw_rest" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id

  depends_on = [
    aws_api_gateway_integration.get_server_hour,
    aws_api_gateway_integration_response.get_server_hour
  ]
}

resource "aws_api_gateway_stage" "prd" {
  deployment_id = aws_api_gateway_deployment.api_gtw_rest.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id
  stage_name    = "prd"

  tags = {
    name    = "prd"
    project = local.project_name
  }
}

output "url_api_gtw" {
  value = aws_api_gateway_deployment.api_gtw_rest.invoke_url
}