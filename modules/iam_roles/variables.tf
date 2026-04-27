variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "roles" {
  description = "Map of IAM roles to create, each with a list of policy ARNs"
  type = map(object({
    policies = list(string)
  }))
}
