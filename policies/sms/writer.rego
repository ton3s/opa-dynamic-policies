package policies.sms.writer
import data.policies.shared.util

roles := ["fortress"]
privileges := [
  { "resource": "sms", "action": "get" },
  { "resource": "sms", "action": "post" }
]

allow["allowed by policies.sms.writer"] {
  util.is_authenticated(roles)
  util.is_authorized(privileges)
}

