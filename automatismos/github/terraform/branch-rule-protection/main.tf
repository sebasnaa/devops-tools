
provider "github" {
  token = var.token
  owner = var.owner
  base_url = ""
}


locals {
  branches    = var.branches
  repositories = var.repositories

  # Nested loop over both lists, and flatten the result.
  repository_branhces = distinct(flatten([

    for repository in local.repositories : [
        for branch in local.branches : {
            branch     = branch
            repository = repository
        }
    ]

  ]))
}



resource "github_branch_protection" "add_rules" {

    for_each      = { for entry in local.repository_branhces: "${entry.repository}.${entry.branch}" => entry }
    repository_id  =  each.value.repository

    pattern         = each.value.branch

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    require_code_owner_reviews = true
    required_approving_review_count = 1


    pull_request_bypassers =  var.bypass_pull_request_allowances_teams
    
  }
}



  
