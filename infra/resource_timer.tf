resource "aws_api_gateway_resource" "timer" {
  parent_id   = aws_api_gateway_rest_api.api_gtw_rest.root_resource_id
  path_part   = "cronometragem"
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
}

# exit timers general
resource "aws_api_gateway_resource" "exit_timer_general" {
  parent_id   = aws_api_gateway_resource.timer.id
  path_part   = "largada_geral"
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
}
resource "aws_api_gateway_method" "post_exit_timer_general" {
  authorization = local.auth_none
  http_method   = local.method_post
  resource_id   = aws_api_gateway_resource.exit_timer_general.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id
}
resource "aws_api_gateway_integration" "post_exit_timer_general" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.exit_timer_general.id
  http_method             = aws_api_gateway_method.post_exit_timer_general.http_method
  integration_http_method = aws_api_gateway_method.post_exit_timer_general.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_prd}/${aws_api_gateway_resource.timer.path_part}/${aws_api_gateway_resource.exit_timer_general.path_part}"
}
resource "aws_api_gateway_method_response" "post_exit_timer_general" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.exit_timer_general.id
  http_method = aws_api_gateway_method.post_exit_timer_general.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
resource "aws_api_gateway_integration_response" "post_exit_timer_general" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.exit_timer_general.id
  http_method = aws_api_gateway_method_response.post_exit_timer_general.http_method
  status_code = aws_api_gateway_method_response.post_exit_timer_general.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }
  depends_on = [aws_api_gateway_integration.post_exit_timer_general]
}

# exit timers
resource "aws_api_gateway_resource" "exit_timer" {
  parent_id   = aws_api_gateway_resource.timer.id
  path_part   = "largadas"
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
}
resource "aws_api_gateway_resource" "id_exit_timer" {
  parent_id   = aws_api_gateway_resource.exit_timer.id
  path_part   = "{id_registro}"
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
}
#GET exit timers
resource "aws_api_gateway_method" "get_exit_timer" {
  authorization = local.auth_none
  http_method   = local.method_get
  resource_id   = aws_api_gateway_resource.exit_timer.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id
}
resource "aws_api_gateway_integration" "get_exit_timer" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.exit_timer.id
  http_method             = aws_api_gateway_method.get_exit_timer.http_method
  integration_http_method = aws_api_gateway_method.get_exit_timer.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_prd}/${aws_api_gateway_resource.timer.path_part}/${aws_api_gateway_resource.exit_timer.path_part}"
}
resource "aws_api_gateway_method_response" "get_exit_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.exit_timer.id
  http_method = aws_api_gateway_method.get_exit_timer.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
resource "aws_api_gateway_integration_response" "get_exit_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.exit_timer.id
  http_method = aws_api_gateway_method_response.get_exit_timer.http_method
  status_code = aws_api_gateway_method_response.get_exit_timer.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }
  depends_on = [aws_api_gateway_integration.get_exit_timer]
}
#POST exit timers
resource "aws_api_gateway_method" "post_exit_timer" {
  authorization = local.auth_none
  http_method   = local.method_post
  resource_id   = aws_api_gateway_resource.exit_timer.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id
}
resource "aws_api_gateway_integration" "post_exit_timer" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.exit_timer.id
  http_method             = aws_api_gateway_method.post_exit_timer.http_method
  integration_http_method = aws_api_gateway_method.post_exit_timer.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_prd}/${aws_api_gateway_resource.timer.path_part}/${aws_api_gateway_resource.exit_timer.path_part}"
}
resource "aws_api_gateway_method_response" "post_exit_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.exit_timer.id
  http_method = aws_api_gateway_method.post_exit_timer.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
resource "aws_api_gateway_integration_response" "post_exit_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.exit_timer.id
  http_method = aws_api_gateway_method_response.post_exit_timer.http_method
  status_code = aws_api_gateway_method_response.post_exit_timer.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }

  depends_on = [aws_api_gateway_integration.post_exit_timer]
}
#PUT exit timers
resource "aws_api_gateway_method" "put_exit_timer" {
  authorization = local.auth_none
  http_method   = local.method_put
  resource_id   = aws_api_gateway_resource.id_exit_timer.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id

  request_parameters = {
    "method.request.path.id_registro" = true
  }
}
resource "aws_api_gateway_integration" "put_exit_timer" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.id_exit_timer.id
  http_method             = aws_api_gateway_method.put_exit_timer.http_method
  integration_http_method = aws_api_gateway_method.put_exit_timer.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_prd}/${aws_api_gateway_resource.timer.path_part}/${aws_api_gateway_resource.exit_timer.path_part}/${aws_api_gateway_resource.id_exit_timer.path_part}"

  request_parameters = {
    "integration.request.path.id_registro" = local.path_id_register
  }
}
resource "aws_api_gateway_method_response" "put_exit_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.id_exit_timer.id
  http_method = aws_api_gateway_method.put_exit_timer.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
resource "aws_api_gateway_integration_response" "put_exit_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.id_exit_timer.id
  http_method = aws_api_gateway_method_response.put_exit_timer.http_method
  status_code = aws_api_gateway_method_response.put_exit_timer.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }
  depends_on = [aws_api_gateway_integration.put_exit_timer]
}
#DELETE exit timers
resource "aws_api_gateway_method" "delete_exit_timer" {
  authorization = local.auth_none
  http_method   = local.method_delete
  resource_id   = aws_api_gateway_resource.id_exit_timer.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id

  request_parameters = {
    "method.request.path.id_registro" = true
  }
}
resource "aws_api_gateway_integration" "delete_exit_timer" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.id_exit_timer.id
  http_method             = aws_api_gateway_method.delete_exit_timer.http_method
  integration_http_method = aws_api_gateway_method.delete_exit_timer.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_prd}/${aws_api_gateway_resource.timer.path_part}/${aws_api_gateway_resource.exit_timer.path_part}/${aws_api_gateway_resource.id_exit_timer.path_part}"

  request_parameters = {
    "integration.request.path.id_registro" = local.path_id_register
  }
}
resource "aws_api_gateway_method_response" "delete_exit_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.id_exit_timer.id
  http_method = aws_api_gateway_method.delete_exit_timer.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
resource "aws_api_gateway_integration_response" "delete_exit_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.id_exit_timer.id
  http_method = aws_api_gateway_method_response.delete_exit_timer.http_method
  status_code = aws_api_gateway_method_response.delete_exit_timer.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }
  depends_on = [aws_api_gateway_integration.delete_exit_timer]
}

# End timers
resource "aws_api_gateway_resource" "end_timer" {
  parent_id   = aws_api_gateway_resource.timer.id
  path_part   = "chegadas"
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
}
resource "aws_api_gateway_resource" "id_end_timer" {
  parent_id   = aws_api_gateway_resource.end_timer.id
  path_part   = "{id_registro}"
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
}
#POST end timers
resource "aws_api_gateway_method" "post_end_timer" {
  authorization = local.auth_none
  http_method   = local.method_post
  resource_id   = aws_api_gateway_resource.end_timer.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id
}
resource "aws_api_gateway_integration" "post_end_timer" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.end_timer.id
  http_method             = aws_api_gateway_method.post_end_timer.http_method
  integration_http_method = aws_api_gateway_method.post_end_timer.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_mock}/${aws_api_gateway_resource.timer.path_part}/${aws_api_gateway_resource.end_timer.path_part}"
}
resource "aws_api_gateway_method_response" "post_end_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.end_timer.id
  http_method = aws_api_gateway_method.post_end_timer.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
resource "aws_api_gateway_integration_response" "post_end_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.end_timer.id
  http_method = aws_api_gateway_method_response.post_end_timer.http_method
  status_code = aws_api_gateway_method_response.post_end_timer.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }
  depends_on = [aws_api_gateway_integration.post_end_timer]
}
#GET end timers
resource "aws_api_gateway_method" "get_end_timer" {
  authorization = local.auth_none
  http_method   = local.method_get
  resource_id   = aws_api_gateway_resource.end_timer.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id
}
resource "aws_api_gateway_integration" "get_end_timer" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.end_timer.id
  http_method             = aws_api_gateway_method.get_end_timer.http_method
  integration_http_method = aws_api_gateway_method.get_end_timer.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_mock}/${aws_api_gateway_resource.timer.path_part}/${aws_api_gateway_resource.end_timer.path_part}"
}
resource "aws_api_gateway_method_response" "get_end_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.end_timer.id
  http_method = aws_api_gateway_method.get_end_timer.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
resource "aws_api_gateway_integration_response" "get_end_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.end_timer.id
  http_method = aws_api_gateway_method_response.get_end_timer.http_method
  status_code = aws_api_gateway_method_response.get_end_timer.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }
  depends_on = [aws_api_gateway_integration.get_end_timer]
}
#PUT end timers
resource "aws_api_gateway_method" "put_end_timer" {
  authorization = local.auth_none
  http_method   = local.method_put
  resource_id   = aws_api_gateway_resource.id_end_timer.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id
  request_parameters = {
    "method.request.path.id_registro" = true
  }
}
resource "aws_api_gateway_integration" "put_end_timer" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.id_end_timer.id
  http_method             = aws_api_gateway_method.put_end_timer.http_method
  integration_http_method = aws_api_gateway_method.put_end_timer.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_mock}/${aws_api_gateway_resource.timer.path_part}/${aws_api_gateway_resource.end_timer.path_part}/${aws_api_gateway_resource.id_end_timer.path_part}"
  request_parameters = {
    "integration.request.path.id_registro" = local.path_id_register
  }
}
resource "aws_api_gateway_method_response" "put_end_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.id_end_timer.id
  http_method = aws_api_gateway_method.put_end_timer.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
resource "aws_api_gateway_integration_response" "put_end_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.id_end_timer.id
  http_method = aws_api_gateway_method_response.put_end_timer.http_method
  status_code = aws_api_gateway_method_response.put_end_timer.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }
  depends_on = [aws_api_gateway_integration.put_end_timer]
}
#DELETE end timers
resource "aws_api_gateway_method" "delete_end_timer" {
  authorization = local.auth_none
  http_method   = local.method_delete
  resource_id   = aws_api_gateway_resource.id_end_timer.id
  rest_api_id   = aws_api_gateway_rest_api.api_gtw_rest.id
  request_parameters = {
    "method.request.path.id_registro" = true
  }
}
resource "aws_api_gateway_integration" "delete_end_timer" {
  rest_api_id             = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id             = aws_api_gateway_resource.id_end_timer.id
  http_method             = aws_api_gateway_method.delete_end_timer.http_method
  integration_http_method = aws_api_gateway_method.delete_end_timer.http_method
  timeout_milliseconds    = local.timeout_api
  type                    = local.type_integration_api
  uri                     = "${var.address_api_mock}/${aws_api_gateway_resource.timer.path_part}/${aws_api_gateway_resource.end_timer.path_part}/${aws_api_gateway_resource.id_end_timer.path_part}"
  request_parameters = {
    "integration.request.path.id_registro" = local.path_id_register
  }
}
resource "aws_api_gateway_method_response" "delete_end_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.id_end_timer.id
  http_method = aws_api_gateway_method.delete_end_timer.http_method
  status_code = local.http_code_ok
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
resource "aws_api_gateway_integration_response" "delete_end_timer" {
  rest_api_id = aws_api_gateway_rest_api.api_gtw_rest.id
  resource_id = aws_api_gateway_resource.id_end_timer.id
  http_method = aws_api_gateway_method_response.delete_end_timer.http_method
  status_code = aws_api_gateway_method_response.delete_end_timer.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = local.allow_origins
  }
  depends_on = [aws_api_gateway_integration.delete_end_timer]
}