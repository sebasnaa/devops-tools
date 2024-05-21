
provider "github" {
  token = var.token
  owner = var.owner
  base_url = ""
}


locals {

  teams = var.teams

  repositories_map = {

    for repo_name in var.repositories :
     repo_name => {
      teams = local.teams
    }
   
  }
}



locals {
  team_repository_map = flatten([
    for repository_name, repository in local.repositories_map : [
      for team_name, team in repository.teams : {
        repository : repository_name,
        team       = team_name,
        permission = team.permission
      }
    ]
  ])
}

resource "github_team_repository" "team_repo" {
  for_each = {
    for team in local.team_repository_map : "${team.repository}:${team.team}" => team
  }

  team_id    = each.value.team
  repository = each.value.repository
  permission = each.value.permission

}