variable "project_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnetipPublic" {
  type = string
}

variable "subnetipPrivate" {
  type = string
}
variable "subnetipPublic1" {
  type = string
}

variable "subnetipPrivate1" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "container_image" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  type = string
}
