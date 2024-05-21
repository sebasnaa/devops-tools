variable "token" {
    type = string
    description = "Token to connect with github organization"
    default = ""
}

variable "owner" {
    type = string
    description = "Organization name"
    default = ""
}

variable "repositories" {
  type        = list
  description = "(Required) List of repositories to update."
  default     = []
}

variable "teams" {
  type = map(object({permission = string}))
  default = {}
}
