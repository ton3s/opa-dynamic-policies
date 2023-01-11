package policies.shared.util
import future.keywords

is_authenticated(roles) {
  some input_role in input.roles
  some role in roles
  lower(input_role) == lower(role)
}

is_authorized(privileges) {
  some privilege in privileges
  lower(privilege.resource) == lower(input.resource)
  lower(privilege.action) == lower(input.action)
}