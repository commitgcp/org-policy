variable "org_id" {
  description = "The organization ID where the policy will be applied."
  type        = string
}

variable "project_id" {
  description = "Name of a project in the organization."
  type        = string
}

variable "region" {
  description = "The region of the project."
  type        = string
}