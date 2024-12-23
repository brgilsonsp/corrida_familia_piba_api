resource "aws_api_gateway_resource" "segment" {
  parent_id   = aws_api_gateway_rest_api.api_gtw_rest.root_resource_id
  path_part   = "segmentacao"
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
}

resource "aws_api_gateway_method" "get_segment" {
  authorization = local.auth_none
  http_method   = local.method_get
  resource_id   = aws_api_gateway_resource.segment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id
}

resource "aws_api_gateway_integration" "get_segment" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.segment.id
  http_method             = aws_api_gateway_method.get_segment.http_method
  integration_http_method = aws_api_gateway_method.get_segment.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_prd}/${aws_api_gateway_resource.segment.path_part}"
}

resource "aws_api_gateway_method_response" "get_segment" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.segment.id
  http_method = aws_api_gateway_method.get_segment.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "get_segment" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.segment.id
  http_method = aws_api_gateway_method_response.get_segment.http_method
  status_code = aws_api_gateway_method_response.get_segment.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }

  depends_on = [aws_api_gateway_integration.get_segment]
}

