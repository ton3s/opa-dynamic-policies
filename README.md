# OPA Dynamic Policy Composition

- https://www.styra.com/blog/dynamic-policy-composition-for-opa/

## Running

`opa run --server --set default_decision=/main/decision .`

Query OPA (use team1-3 as input, and try removing the `explain` attribute):

`curl -d '{"resource": "sms", "roles": ["fortress"], "action": "get", "explain": true}' http://localhost:8181 | jq `

Or if you prefer using `opa eval`:

```shell
opa eval -f pretty -d . 'data.main.decision with input as {"resource": "sms", "roles": ["fortress"], "action": "get", "explain": true}'
```
