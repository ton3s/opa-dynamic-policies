package policies.sms.reader
import future.keywords

allowed_roles := ["fortress"]
privileges := [
  { "resource": "sms", "action": "get" }
]

allow {
  is_authenticated
  is_authorized
}

is_authenticated {
  some input_role in input.roles
  some allowed_role in allowed_roles
  lower(input_role) == lower(allowed_role)
}

is_authorized {
  some privilege in privileges
  lower(privilege.resource) == lower(input.resource)
  lower(privilege.action) == lower(input.action)
}

deny[msg] {
    not allow
    msg = "denied by sms.reader"
}

