== Serde

- popular serialization and deserialization framework in rust
- you cannot transfer struct / JSON over the network | its either bytes or string(also bytes)

- by default all the features are not included
- if you want then
```toml
[dependencies]
serde = { version =  "", features = ["derive"] }
serde_json = ""
```

- `serde_json::to_string(s)`
- `let u: Result<User, serde_json::Error> = serde_json::from_str(s)`

== Borsh
- *Binary Object Representation Serializer for Hashing*
- bunch of deterministic bytes
- *NEAR Protocol*
