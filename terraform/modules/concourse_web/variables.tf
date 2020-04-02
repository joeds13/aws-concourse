variable "name" {
  description = "common name"
  type        = string
}

variable "tags" {
  description = "tags to apply to aws resource"
  type        = map(string)
}

variable "ami_id" {}
variable "cognito" {}
variable "concourse" {}
variable "concourse_keys" {}
variable "concourse_secrets" {}
variable "database" {}
variable "database_secrets" {}
variable "internal_loadbalancer" {}
variable "loadbalancer" {}
variable "log_group" {}
variable "vpc" {}
variable "ssm_name_prefix" {}


variable "web" {
  description = "atc/tsa configuration options"

  type = object({
    count                 = number
    max_instance_lifetime = number
    instance_type         = string
    environment_override  = map(string)
  })

  default = {
    instance_type         = "t3.micro"
    max_instance_lifetime = 60 * 60 * 24 * 7
    count                 = 3
    environment_override  = {}
  }
}

variable "proxy" {
  type = map(string)
  default = {
    http_proxy  = ""
    https_proxy = ""
    no_proxy    = ""
  }
}

variable "github_cidr_block" {
  type    = string
  default = ""
}

variable "s3_prefix_list_id" {
  type    = string
  default = ""
}
