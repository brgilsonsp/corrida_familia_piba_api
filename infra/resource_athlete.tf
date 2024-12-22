resource "aws_api_gateway_resource" "athlete" {
  parent_id   = aws_api_gateway_rest_api.api_gtw_rest.root_resource_id
  path_part   = "atletas"
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
}

resource "aws_api_gateway_resource" "id_athlete" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  parent_id   = aws_api_gateway_resource.athlete.id
  path_part   = "{id_atleta}"
}

#GET
resource "aws_api_gateway_method" "get_athlete" {
  authorization = local.auth_none
  http_method   = local.method_get
  resource_id   = aws_api_gateway_resource.athlete.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id
}

resource "aws_api_gateway_integration" "get_athlete" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.athlete.id
  http_method             = aws_api_gateway_method.get_athlete.http_method
  integration_http_method = aws_api_gateway_method.get_athlete.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_mock}/${aws_api_gateway_resource.athlete.path_part}"
}

resource "aws_api_gateway_method_response" "get_athlete" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.athlete.id
  http_method = aws_api_gateway_method.get_athlete.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "get_athlete" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.athlete.id
  http_method = aws_api_gateway_method_response.get_athlete.http_method
  status_code = aws_api_gateway_method_response.get_athlete.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }

  depends_on = [aws_api_gateway_integration.get_athlete]
}

#POST
resource "aws_api_gateway_method" "post_athlete" {
  authorization = local.auth_none
  http_method   = local.method_post
  resource_id   = aws_api_gateway_resource.athlete.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id
}

resource "aws_api_gateway_integration" "post_athlete" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.athlete.id
  http_method             = aws_api_gateway_method.post_athlete.http_method
  integration_http_method = aws_api_gateway_method.post_athlete.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_mock}/${aws_api_gateway_resource.athlete.path_part}"
}

resource "aws_api_gateway_method_response" "post_athlete" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.athlete.id
  http_method = aws_api_gateway_method.post_athlete.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "post_athlete" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.athlete.id
  http_method = aws_api_gateway_method_response.post_athlete.http_method
  status_code = aws_api_gateway_method_response.post_athlete.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }

  depends_on = [aws_api_gateway_integration.post_athlete]
}

#DELETE
resource "aws_api_gateway_method" "delete_athlete" {
  authorization = local.auth_none
  http_method   = local.method_delete
  resource_id   = aws_api_gateway_resource.id_athlete.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id

  request_parameters = {
    "method.request.path.id_atleta" = true
  }
}

resource "aws_api_gateway_integration" "delete_athlete" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.id_athlete.id
  http_method             = aws_api_gateway_method.delete_athlete.http_method
  integration_http_method = aws_api_gateway_method.delete_athlete.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_mock}/${aws_api_gateway_resource.athlete.path_part}/${aws_api_gateway_resource.id_athlete.path_part}"

  request_parameters = {
    "integration.request.path.id_atleta" = local.path_id_athlete
  }
}

resource "aws_api_gateway_method_response" "delete_athlete" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.id_athlete.id
  http_method = aws_api_gateway_method.delete_athlete.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "delete_athlete" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.id_athlete.id
  http_method = aws_api_gateway_method_response.delete_athlete.http_method
  status_code = aws_api_gateway_method_response.delete_athlete.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }

  depends_on = [aws_api_gateway_integration.delete_athlete]
}

#PUT
resource "aws_api_gateway_method" "put_athlete" {
  authorization = local.auth_none
  http_method   = local.method_put
  resource_id   = aws_api_gateway_resource.id_athlete.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id

  request_parameters = {
    "method.request.path.id_atleta" = true
  }
}

resource "aws_api_gateway_integration" "put_athlete" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.id_athlete.id
  http_method             = aws_api_gateway_method.put_athlete.http_method
  integration_http_method = aws_api_gateway_method.put_athlete.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_mock}/${aws_api_gateway_resource.athlete.path_part}/${aws_api_gateway_resource.id_athlete.path_part}"

  request_parameters = {
    "integration.request.path.id_atleta" = local.path_id_athlete
  }
}

resource "aws_api_gateway_method_response" "put_athlete" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.id_athlete.id
  http_method = aws_api_gateway_method.put_athlete.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "put_athlete" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.id_athlete.id
  http_method = aws_api_gateway_method_response.put_athlete.http_method
  status_code = aws_api_gateway_method_response.put_athlete.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }

  depends_on = [aws_api_gateway_integration.put_athlete]
}

