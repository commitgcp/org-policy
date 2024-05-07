locals {
  policy_data = yamldecode(file("${path.module}/policies.yaml"))
}

resource "google_organization_policy" "org_policy" {
  for_each = local.policy_data

  org_id     = var.org_id
  constraint = "constraints/${each.key}"

  dynamic "boolean_policy" {
    for_each = lookup(each.value, "enforce", null) != null ? [1] : []
    content {
      enforced = each.value.enforce
    }
  }

  dynamic "list_policy" {
    for_each = contains(keys(each.value), "denied_values") ? [1] : []
    content {
      deny {
        values = each.value.denied_values
      }
    }
  }

  dynamic "list_policy" {
    for_each = contains(keys(each.value), "allowed_values") ? [1] : []
    content {
      allow {
        values = each.value.allowed_values
      }
    }
  }
}


