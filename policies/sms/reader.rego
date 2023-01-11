package policies.sms.reader
import data.policies.shared.util

roles := ["fortress", "knights"]
privileges := [
  { "resource": "sms", "action": "get" }
]

allow["allowed by policies.sms.reader"] {
  util.is_authenticated(roles)
  util.is_authorized(privileges)
}


