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

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.configuration.id,
      aws_api_gateway_resource.server_hour.id,
      aws_api_gateway_method.get_server_hour.id,
      aws_api_gateway_integration.get_server_hour.id,
      aws_api_gateway_resource.athlete.id,
      aws_api_gateway_resource.id_athlete.id,
      aws_api_gateway_method.get_athlete.id,
      aws_api_gateway_integration.get_athlete.id,
      aws_api_gateway_method.post_athlete.id,
      aws_api_gateway_integration.post_athlete.id,
      aws_api_gateway_method.delete_athlete.id,
      aws_api_gateway_integration.delete_athlete.id,
      aws_api_gateway_method.put_athlete.id,
      aws_api_gateway_integration.put_athlete.id,
      aws_api_gateway_resource.timer.id,
      aws_api_gateway_resource.exit_timer.id,
      aws_api_gateway_resource.exit_timer_general.id,
      aws_api_gateway_method.post_exit_timer_general.id,
      aws_api_gateway_integration.post_exit_timer_general.id,
      aws_api_gateway_resource.id_exit_timer.id,
      aws_api_gateway_method.get_exit_timer.id,
      aws_api_gateway_integration.get_exit_timer.id,
      aws_api_gateway_method.post_exit_timer.id,
      aws_api_gateway_integration.post_exit_timer.id,
      aws_api_gateway_method.put_exit_timer.id,
      aws_api_gateway_integration.put_exit_timer.id,
      aws_api_gateway_method.delete_exit_timer.id,
      aws_api_gateway_integration.delete_exit_timer.id,
      aws_api_gateway_resource.end_timer.id,
      aws_api_gateway_resource.id_end_timer.id,
      aws_api_gateway_integration.post_end_timer.id,
      aws_api_gateway_method.post_end_timer.id,
      aws_api_gateway_integration.get_end_timer.id,
      aws_api_gateway_method.get_end_timer.id,
      aws_api_gateway_integration.put_end_timer.id,
      aws_api_gateway_method.put_end_timer.id,
      aws_api_gateway_integration.delete_end_timer.id,
      aws_api_gateway_method.delete_end_timer.id,
      aws_api_gateway_resource.classification.id,
      aws_api_gateway_integration.get_classification.id,
      aws_api_gateway_method.get_classification.id,
      aws_api_gateway_resource.close_race.id,
      aws_api_gateway_integration.post_close_race.id,
      aws_api_gateway_method.post_close_race.id,
      aws_api_gateway_resource.segment.id,
      aws_api_gateway_integration.get_segment.id,
      aws_api_gateway_method.get_segment.id
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.get_server_hour,
    aws_api_gateway_integration_response.get_server_hour,
    aws_api_gateway_integration.get_athlete,
    aws_api_gateway_integration_response.get_athlete,
    aws_api_gateway_integration.post_athlete,
    aws_api_gateway_integration_response.post_athlete,
    aws_api_gateway_integration.delete_athlete,
    aws_api_gateway_integration_response.delete_athlete,
    aws_api_gateway_integration.put_athlete,
    aws_api_gateway_integration_response.put_athlete,
    aws_api_gateway_integration.post_exit_timer_general,
    aws_api_gateway_integration_response.post_exit_timer_general,
    aws_api_gateway_integration.post_exit_timer,
    aws_api_gateway_integration_response.post_exit_timer,
    aws_api_gateway_integration.put_exit_timer,
    aws_api_gateway_integration_response.put_exit_timer,
    aws_api_gateway_integration.delete_exit_timer,
    aws_api_gateway_integration_response.delete_exit_timer,
    aws_api_gateway_integration.post_end_timer,
    aws_api_gateway_integration_response.post_end_timer,
    aws_api_gateway_integration.get_end_timer,
    aws_api_gateway_integration_response.get_end_timer,
    aws_api_gateway_integration.put_end_timer,
    aws_api_gateway_integration_response.put_end_timer,
    aws_api_gateway_integration.delete_end_timer,
    aws_api_gateway_integration_response.delete_end_timer,
    aws_api_gateway_integration.get_classification,
    aws_api_gateway_integration_response.get_classification,
    aws_api_gateway_integration.post_close_race,
    aws_api_gateway_integration_response.post_close_race,
    aws_api_gateway_integration.get_segment,
    aws_api_gateway_integration_response.get_segment
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