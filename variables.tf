variable "azs" {
  description = "List of AZs in AWS eu-west region."
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "infra_name" {
  description = "Infrastructure name."
  type = string
  default = "exampleapp"
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name."
  type = string
  default = "public"
}

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name."
  type = string
  default = "private"
}

variable "db_subnet_suffix" {
  description = "Suffix to append to db subnets name."
  type = string
  default = "db"
}