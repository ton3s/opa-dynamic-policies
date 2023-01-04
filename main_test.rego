package main_test

import data.main

test_compute_allow {
    main.decision == {
        "allow": true,
        "reason": ""
    } with input as {"resource": "compute"}
}