package policies.sms.writer
import data.policies.shared.util

roles := ["fortress"]
privileges := [
  { "resource": "sms", "action": "get" },
  { "resource": "sms", "action": "post" }
]

allow[msg] {
  util.is_authenticated(roles)
  util.is_authorized(privileges)
  msg = "allowed by sms.writer"
}

