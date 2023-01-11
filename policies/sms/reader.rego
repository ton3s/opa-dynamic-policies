package policies.sms.reader
import data.policies.shared.util

roles := ["fortress", "knights"]
privileges := [
  { "resource": "sms", "action": "get" }
]

allow[msg] {
  util.is_authenticated(roles)
  util.is_authorized(privileges)
  msg = "allowed by sms.reader"
}


