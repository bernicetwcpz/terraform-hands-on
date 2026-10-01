variable "prefix" {
  type        = string
  default     = "sample"
  description = "Prefix to append to all cloud resources"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Target deployment environment"

  validation {
    condition     = contains(["local", "dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: local,dev, staging, prod."
  }
}