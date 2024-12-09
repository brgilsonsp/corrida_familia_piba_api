resource "aws_cloudwatch_log_group" "api_gtw_log" {
  name              = local.api_gtw_name
  retention_in_days = local.retention_log

  tags = {
    name    = local.api_gtw_name
    project = local.project_name
  }
}