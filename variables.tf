variable "name" {}

variable "runtime" {
  default = null
}

variable "handler" {
  default = null
}

variable "memory_size" {
  default = null
}

variable "timeout" {
  default = null
}

variable "reserved_concurrent_executions" {
  default = null
}

variable "s3_bucket" {
  default = null
}

variable "s3_key" {
  default = null
}

variable "source_code_hash" {
  default = null
}

variable "layers" {
  type = set(string)
  default = null
}

variable "environment" {
  type = object({
    variables = optional(map(string))
  })
  default = null
}

variable "vpc_config" {
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
  default = null
}

variable "role" {
  type = object({
    policy_statement = optional(list(any))
    policy_arns = optional(list(string))
  })
}