# resource /atletas
resource "aws_api_gateway_resource" "athletes_piba" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_piba.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_piba.root_resource_id
  path_part   = local.path_athlete
}


# resource GET /atletas
resource "aws_api_gateway_method" "get_athletes_piba" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_piba.id
  resource_id   = aws_api_gateway_resource.athletes_piba.id
  http_method   = local.http_get
  authorization = local.auth_type
}
resource "aws_api_gateway_integration" "get_athletes_piba" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway_piba.id
  resource_id             = aws_api_gateway_resource.athletes_piba.id
  http_method             = aws_api_gateway_method.get_athletes_piba.http_method
  integration_http_method = aws_api_gateway_method.get_athletes_piba.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integrations
  uri                     = "${local.uri_backend}/${local.path_athlete}"
  #uri                  = "http://${aws_lb.lb-piba.dns_name}:${local.port_api_backend}/${local.context_path}/${local.path_athlete}"
  #connection_type      = "VPC_LINK"
  #connection_id        = aws_api_gateway_vpc_link.vpc_link_piba.id
}
resource "aws_api_gateway_method_response" "get_athletes_piba" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_piba.id
  resource_id = aws_api_gateway_resource.athletes_piba.id
  http_method = aws_api_gateway_method.get_athletes_piba.http_method
  status_code = local.http_status_ok

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
resource "aws_api_gateway_integration_response" "get_athletes_piba" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_piba.id
  resource_id = aws_api_gateway_resource.athletes_piba.id
  http_method = aws_api_gateway_method.get_athletes_piba.http_method
  status_code = aws_api_gateway_method_response.get_athletes_piba.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origin
  }

  depends_on = [aws_api_gateway_integration.get_athletes_piba]
}

# resource PUT /atletas
resource "aws_api_gateway_method" "put_athletes_piba" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_piba.id
  resource_id   = aws_api_gateway_resource.athletes_piba.id
  http_method   = local.http_put
  authorization = local.auth_type
}

resource "aws_api_gateway_integration" "put_athletes_piba" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway_piba.id
  resource_id             = aws_api_gateway_resource.athletes_piba.id
  http_method             = aws_api_gateway_method.put_athletes_piba.http_method
  integration_http_method = aws_api_gateway_method.put_athletes_piba.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integrations
  uri                     = "${local.uri_backend}/${local.path_athlete}"
  #uri                  = "http://${aws_lb.lb-piba.dns_name}:${local.port_api_backend}/${local.context_path}/${local.path_athlete}"
  #connection_type      = "VPC_LINK"
  #connection_id        = aws_api_gateway_vpc_link.vpc_link_piba.id
}

resource "aws_api_gateway_method_response" "put_athletes_piba" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_piba.id
  resource_id = aws_api_gateway_resource.athletes_piba.id
  http_method = aws_api_gateway_method.put_athletes_piba.http_method
  status_code = local.http_status_ok

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "put_athletes_piba" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_piba.id
  resource_id = aws_api_gateway_resource.athletes_piba.id
  http_method = aws_api_gateway_method.put_athletes_piba.http_method
  status_code = aws_api_gateway_method_response.put_athletes_piba.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origin
  }

  depends_on = [aws_api_gateway_integration.put_athletes_piba]
}