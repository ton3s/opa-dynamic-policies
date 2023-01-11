# OPA Dynamic Policy Composition

- https://www.styra.com/blog/dynamic-policy-composition-for-opa/

## Running

`opa run --server --set default_decision=/main/decision .`

Query OPA:

`curl -d '{"resource": "sms", "roles": ["fortress"], "action": "get", "explain": true}' http://localhost:8181 | jq`

```shell
{
  "allow": true,
  "explain": {
    "reader": [
      "allowed by sms.reader"
    ],
    "writer": [
      "allowed by sms.writer"
    ]
  },
  "reason": ""
}
```

Or if you prefer using `opa eval`:

`opa eval -f pretty -d . 'data.main.decision with input as {"resource": "sms", "roles": ["fortress"], "action": "get", "explain": true}'`

## Testing

`opa test . -v`

```shell
main_test.rego:
data.main_test.test_sms_allow: PASS (2.465861ms)
data.main_test.test_sms_deny: PASS (698.949µs)
--------------------------------------------------------------------------------
PASS: 2/2
```

## List policies

`curl http://localhost:8181/v1/policies | jq '.result[]' | jq '{id, raw}'  `

```json
{
  "id": "policies/shared/util.rego",
  "raw": "package policies.shared.util\nimport future.keywords\n\nis_authenticated(roles) {\n  some input_role in input.roles\n  some role in roles\n  lower(input_role) == lower(role)\n}\n\nis_authorized(privileges) {\n  some privilege in privileges\n  lower(privilege.resource) == lower(input.resource)\n  lower(privilege.action) == lower(input.action)\n}"
}
{
  "id": "policies/sms/reader.rego",
  "raw": "package policies.sms.reader\nimport data.policies.shared.util\n\nroles := [\"fortress\", \"knights\"]\nprivileges := [\n  { \"resource\": \"sms\", \"action\": \"get\" }\n]\n\nallow[\"allowed by policies.sms.reader\"] {\n  util.is_authenticated(roles)\n  util.is_authorized(privileges)\n}\n\n\n"
}
{
  "id": "policies/sms/writer.rego",
  "raw": "package policies.sms.writer\nimport data.policies.shared.util\n\nroles := [\"fortress\"]\nprivileges := [\n  { \"resource\": \"sms\", \"action\": \"get\" },\n  { \"resource\": \"sms\", \"action\": \"post\" }\n]\n\nallow[\"allowed by policies.sms.writer\"] {\n  util.is_authenticated(roles)\n  util.is_authorized(privileges)\n}\n\n"
}
{
  "id": "main.rego",
  "raw": "package main\n\nrouter[policy] = data.policies[name][policy].allow\n\nallow[msg] {\n    policy := router[_]\n    msg := policy[_]\n}\n\ndecision[\"allow\"] = count(allow) > 0\ndecision[\"explain\"] = router {\n    input.explain == true\n}\n"
}
{
  "id": "main_test.rego",
  "raw": "package main_test\nimport future.keywords\nimport data.main\n\ntest_sms_allow {\n    main.decision.allow with input as {\"resource\": \"sms\", \"roles\": [\"fortress\"], \"action\": \"get\"}\n}\n\ntest_sms_deny {\n    not main.decision.allow with input as {\"resource\": \"sms\", \"roles\": [\"district-nine\"], \"action\": \"get\"}\n}"
}
```
