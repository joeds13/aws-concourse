resource "aws_cloudwatch_log_group" "log_group" {
  name = "/${var.name}/${var.group_name}"

  lifecycle {
    prevent_destroy = true
  }
}
