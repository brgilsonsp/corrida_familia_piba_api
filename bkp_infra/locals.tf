locals {
  cidr_vpc               = "11.0.0.0/16"
  cidr_servers           = "11.0.1.0/24"
  cidr_internet          = "0.0.0.0/0"
  uri_backend            = "http://${aws_instance.backend_instance_piba.public_ip}:${local.port_api_backend}/${local.context_path}"
  port_api_backend       = "9111"
  context_path           = "corre-familia"
  path_athlete           = "atletas"
  path_timer             = "cronometros"
  path_segment           = "segmentos"
  path_classifications   = "classificacoes"
  http_get               = "GET"
  http_post              = "POST"
  http_put               = "PUT"
  auth_type              = "NONE"
  allow_origin           = "'*'"
  http_status_ok         = "200"
  timeout_api            = 29000
  type_integrations      = "HTTP_PROXY"
  tag_project            = "corre-familia-piba"
  name_vpc               = "vpc-${local.tag_project}"
  name_lb                = "lb-${local.tag_project}"
  name_ec2               = "server-${local.tag_project}"
  name_role_ec2_piba     = "role_ec2_piba-${local.tag_project}"
  name_subnet            = "subnet-${local.tag_project}"
  name_igw               = "igw-${local.tag_project}"
  name_route_table       = "route_table-${local.tag_project}"
  name_sg                = "sg_${local.tag_project}"
  name_tg                = "target-group-${local.tag_project}"
  name_lb_listener       = "lb-listener-${local.tag_project}"
  name_api_gtw           = "api-gtw-${local.tag_project}"
  name_vpc_link          = "vpc-link-${local.tag_project}"
  name_cw_api            = "cloud_watch_api_gtw-${local.tag_project}"
  name_s3_log_lb         = "log-lb-piba-${local.tag_project}"
  name_role_api_gtw_cw   = "role_api_gtw_cloudwatch-${local.tag_project}"
  name_policy_api_gtw_cw = "policy_api_gtw_cloudwatch-${local.tag_project}"
}