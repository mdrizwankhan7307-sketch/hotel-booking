variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "container_image" {
  description = "Docker Image"
  type        = string
}

variable "container_port" {
  description = "Application Port"
  type        = number
  default     = 8080
}

variable "desired_count" {
  description = "Number of ECS Tasks"
  type        = number
  default     = 2
}

variable "private_subnet_ids" {
  description = "Private Subnets"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "ECS Security Group"
  type        = string
}

variable "target_group_arn" {
  description = "ALB Target Group"
  type        = string
}