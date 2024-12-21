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
  stage_name    = local.stage

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gtw_log.arn
    format = jsonencode({
      requestId      = "$context.requestId",
      ip             = "$context.identity.sourceIp",
      caller         = "$context.identity.caller",
      user           = "$context.identity.user",
      requestTime    = "$context.requestTime",
      httpMethod     = "$context.httpMethod",
      resourcePath   = "$context.resourcePath",
      status         = "$context.status",
      protocol       = "$context.protocol",
      responseLength = "$context.responseLength"
    })
  }

  variables = {
    environment = local.stage
  }

  tags = {
    name    = local.stage
    project = local.project_name
  }

  depends_on = [
    aws_cloudwatch_log_group.api_gtw_log
  ]
}

resource "aws_api_gateway_method_settings" "all_apis_runner_piba" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  stage_name  = aws_api_gateway_stage.prd.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = false
    logging_level   = "ERROR"
  }
}

output "url_api_gtw" {
  value = aws_api_gateway_deployment.api_gtw_rest.invoke_url
}