resource "aws_api_gateway_resource" "configuration" {
  parent_id   = aws_api_gateway_rest_api.api_gtw_rest.root_resource_id
  path_part   = "configuracoes"
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
}

resource "aws_api_gateway_resource" "server_hour" {
  parent_id   = aws_api_gateway_resource.configuration.id
  path_part   = "hora_servidor"
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
}

resource "aws_api_gateway_method" "get_server_hour" {
  authorization = local.auth_none
  http_method   = local.method_get
  resource_id   = aws_api_gateway_resource.server_hour.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id
}

resource "aws_api_gateway_integration" "get_server_hour" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.server_hour.id
  http_method             = aws_api_gateway_method.get_server_hour.http_method
  integration_http_method = aws_api_gateway_method.get_server_hour.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api}/${aws_api_gateway_resource.configuration.path_part}/${aws_api_gateway_resource.server_hour.path_part}"
}

resource "aws_api_gateway_method_response" "get_server_hour" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.server_hour.id
  http_method = aws_api_gateway_method.get_server_hour.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "get_server_hour" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.server_hour.id
  http_method = aws_api_gateway_method_response.get_server_hour.http_method
  status_code = aws_api_gateway_method_response.get_server_hour.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }

  depends_on = [aws_api_gateway_integration.get_server_hour]
}
