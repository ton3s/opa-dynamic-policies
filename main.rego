package main

applicable_policy := {
"sms": "sms",
"compute": "compute"
}

name := applicable_policy[input.resource]

router[policy] = data.policies[name][policy].allow

deny[msg] {
    not name
    msg := sprintf("no applicable policy found for input.resource %v", [input.resource])
}

allow[msg] {
    policy := router[_]
    msg := policy[_]
}

decision["allow"] = count(allow) > 0
decision["reason"] =  concat(" | ", deny)
decision["explain"] = router {
    input.explain == true
}
