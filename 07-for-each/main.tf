terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

resource "null_resource" "server" {
  for_each = {
    web        = "frontend"
    app        = "backend"
    monitoring = "grafana"
  }

  triggers = {
    role = each.value
  }
}
