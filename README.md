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
