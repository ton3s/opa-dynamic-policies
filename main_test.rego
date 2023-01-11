package main_test
import future.keywords
import data.main

test_sms_allow {
    main.decision.allow with input as {"resource": "sms", "roles": ["fortress"], "action": "get"}
}

test_sms_deny {
    not main.decision.allow with input as {"resource": "sms", "roles": ["district-nine"], "action": "get"}
}