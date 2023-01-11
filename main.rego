package main

router[policy] = data.policies[name][policy].allow

allow[msg] {
    policy := router[_]
    msg := policy[_]
}

decision["allow"] = count(allow) > 0
decision["explain"] = router {
    input.explain == true
}
