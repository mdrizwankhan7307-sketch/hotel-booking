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

variable "project_name" {
  type = string
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

