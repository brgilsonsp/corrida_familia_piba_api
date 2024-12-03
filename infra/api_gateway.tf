resource "aws_api_gateway_rest_api" "api_gateway_piba" {
  name        = local.name_api_gtw
  description = "API Gateway to backend"

  tags = {
    Name    = local.name_api_gtw,
    project = local.tag_project
  }
}

resource "aws_api_gateway_usage_plan" "api_usage_plan_piba" {
  name        = "piba runner"
  description = "limitation to API Gateway"

  api_stages {
    api_id = aws_api_gateway_rest_api.api_gateway_piba.id
    stage  = aws_api_gateway_stage.api_stage_piba.stage_name
  }

  /*throttle_settings {
    burst_limit = 5
    rate_limit  = 10
  }*/
}

resource "aws_api_gateway_deployment" "api_deployment_piba" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_piba.id

  depends_on = [
    aws_api_gateway_integration.get_athletes_piba,
    aws_api_gateway_method_response.get_athletes_piba,
    aws_api_gateway_integration_response.get_athletes_piba,
    aws_api_gateway_integration.put_athletes_piba,
    aws_api_gateway_method_response.put_athletes_piba,
    aws_api_gateway_integration_response.put_athletes_piba,
    aws_api_gateway_integration.post_timer_piba,
    aws_api_gateway_method_response.post_timer_piba,
    aws_api_gateway_integration_response.post_timer_piba,
    aws_api_gateway_integration.get_segments_piba,
    aws_api_gateway_method_response.get_segments_piba,
    aws_api_gateway_integration_response.get_segments_piba,
    aws_api_gateway_integration.get_classifications_piba,
    aws_api_gateway_method_response.get_classifications_piba,
    aws_api_gateway_integration_response.get_classifications_piba
  ]
}

resource "aws_api_gateway_stage" "api_stage_piba" {
  stage_name    = local.context_path
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_piba.id
  deployment_id = aws_api_gateway_deployment.api_deployment_piba.id

  /* access_log_settings {
    destination_arn = aws_cloudwatch_log_group.log_api_gtw.arn
    format = jsonencode({
      requestId      = "$context.requestId",
      ip             = "$context.identity.sourceIp",
      caller         = "$context.identity.caller",
      user           = "$context.identity.user",
      requestTime    = "$context.requestTime",
      httpMethod     = "$context.httpMethod",
      resourcePath   = "$context.resourcePath",
      status         = "$context.status",
      responseLength = "$context.responseLength"
    })
  }

  depends_on = [
    aws_api_gateway_deployment.api_deployment_piba,
    aws_cloudwatch_log_group.log_api_gtw,
    aws_api_gateway_account.main
  ]*/

}

/*resource "aws_api_gateway_account" "main" {
  cloudwatch_role_arn = aws_iam_role.role_api_gtw_cloudwatch_piba.arn

  depends_on = [
    aws_iam_role.role_api_gtw_cloudwatch_piba,
    aws_iam_policy.policy_api_gateway_cloudwatch_piba
  ]
}*/

/*resource "aws_api_gateway_vpc_link" "vpc_link_piba" {
  name        = local.name_vpc_link
  target_arns = [aws_lb.lb-piba.arn]
  tags = {
    Name    = local.name_vpc_link,
    project = local.tag_project
  }

  depends_on = [aws_lb.lb-piba]
}*/