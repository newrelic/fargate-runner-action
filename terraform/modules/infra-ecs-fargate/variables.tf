# Existing infra
variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS account id"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the EFS volume"
  type        = string
}

variable "vpc_subnet_id" {
  description = "VPC ID for the EFS volume"
  type        = string
}

# Infra to create variables
variable "cluster_name" {
  description = "The name to AWS ECS cluster"
  type        = string
}

variable "cloudwatch_log_group" {
  description = "Cloudwatch log group for the task definition"
  type        = string
}

variable "s3_terraform_bucket_arn" {
  description = "S3 bucket ARN for ECS cluster permissions"
  type        = string
}

variable "task_container_image" {
  description = "Task definition container image"
  type        = string
}

variable "task_container_name" {
  description = "Task definition container name"
  type        = string
}

variable "task_name_prefix" {
  description = "Task name prefix"
  type        = string
}

variable "task_custom_policies" {
  description = "Task custom policies json"
  type    = list(string)
  default = []
}

variable "task_secrets" {
  description = "Task secrets"
  type = list(object({
    name = string
    valueFrom = string
  }))
  default = []
}

variable "efs_volume_name" {
    description = "Efs volume name"
    type        = string
}

variable "efs_volume_mount_point" {
  description = "Efs volume mount point"
  type        = string
}

variable "additional_efs_security_group_rules" {
  description = "Efs volume mount point"
  type        = list(any)
  default     = []
}

### Canaries security group for EFS volume permissions
variable "canaries_security_group" {
    default = "sg-044ef7bc34691164a"
    type    = string
}

## OIDC variables

variable "oidc_repository" {
  description = "OIDC repository ID"
  type        = string
}
variable "oidc_role_name" {
  description = "OIDC role name"
  type        = string
}

## With defaults


variable "cloudwatch_log_prefix" {
  default = "ecs"
  description = "Cloudwatch log prefix for the task definition"
  type        = string
}

variable "task_container_cpu" {
  default = "4096"
}

variable "task_container_memory" {
  default = "30720"
}

variable "task_container_memory_reservation" {
  default = "2048"
}
