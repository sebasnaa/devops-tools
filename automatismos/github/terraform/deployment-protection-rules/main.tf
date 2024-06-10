
provider "github" {
  token = var.token
  owner = var.owner

}


locals {
  repositories = var.repositories

  # Nested loop over both lists, and flatten the result.
  repository_branhces = distinct(flatten([

    for repository in local.repositories : [
      { repository = repository }

    ]

  ]))
}



resource "github_repository_environment" "example" {
  provider    = github
  environment = "example"
  for_each   = { for entry in local.repository_branhces : "${entry.repository}" => entry }
  repository = each.value.repository

  prevent_self_review = true

  reviewers {
    teams = ["id_team_a","id_team_b"]
  }

}




