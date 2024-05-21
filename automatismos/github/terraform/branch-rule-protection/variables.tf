variable "bypass_pull_request_allowances_teams" {
  type        = list(string)
  description = "(Required) The list of team allowed to bypass pull request requirements."
  default     = []
}


variable "required_approving_review_count" {
  type        = number
  description = "Require x number of approvals to satisfy branch protection requirements. If this is specified it must be a number between 0-6."
  default     = 1
}


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

variable "branches" {
  type        = list
  description = "(Required) List of branches to protect."
  default     = []
}