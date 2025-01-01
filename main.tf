module "role" {
  source  = "app.terraform.io/ptonini-org/iam-role/aws"
  version = "~> 1.0.0"
  name    = "lambda-${var.name}"
  assume_role_policy_statement = [{
    actions    = "sts:AssumeRole"
    effect    = "Allow"
    principals = [{ Service = "lambda.amazonaws.com" }]
  }]
  policy_statement = var.role.policy_statement
  policy_arns      = var.role.policy_arns
}

resource "aws_lambda_function" "this" {
  function_name                  = var.name
  role                           = module.role.this.arn
  runtime                        = var.runtime
  handler                        = var.handler
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  reserved_concurrent_executions = var.reserved_concurrent_executions
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  source_code_hash               = var.source_code_hash
  layers                         = var.layers

  dynamic "environment" {
    for_each = var.environment[*]
    content {
      variables = environment.value.variables
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config[*]
    content {
      subnet_ids         = vpc_config.value.subnet_ids
      security_group_ids = vpc_config.value.security_group_ids
    }
  }
}