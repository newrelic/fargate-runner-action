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
  description = "Task *execution (launching)* custom policies json. The rights provided here will be added to the role *launching* the Fargate task. Note that these rights allow, for instance, reading an AWS Secret that is passed to the task as an environment variable (through the task_secrets variable) when *launching* it. These rights are different from the ones the processes running inside of the Fargate task have. For instance, if the task needs to launch some EC2 instances, you'd need to give it ec2:* rights through the task_runtime_custom_policies variable."
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

variable "task_runtime_custom_policies" {
  description = "Task *runtime* custom policies json. The rights provided here will be available to the processes running inside of the launched Fargate task. For instance, if the task needs to launch some EC2 instances, you'd need to give it the required ec2:* rights through this variable. The task is always given the minimum permissions to access the Terraform S3 state bucket. If this variable is not provided, ec2:* rights will be given to guarantee the backwards compatibility of this module. Ideally, users of this module should provide their minimum set of necessary rights for the task runtime via this variable."
  type    = list(string)
  default = null
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

variable "tags" {
  type = map
  default = {
    owning_team = "CAOS"
  }
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

variable "iam_permissions_boundary_policy_arn" {
  default = ""
  description = "A policy boundary to limit the permissions granted to the IAM roles created by this module"
  type = string
}
