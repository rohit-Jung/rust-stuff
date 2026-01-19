== Rust

- ahead of time compiled language meaning the compiled code can run without having rust in a machine
- *rustaceans*

== rustc
- a rust compiler

== cargo
- build system and package manager for rust(similar to npm in ts ecosystem)
- git files won't be generate if you run `cargo new` inside a git repo. to override `cargo new --vcs=git`
- `cargot.toml` - tom's Obvious Minimal Language
- `cargo run`- build and run  | if file isn't changed it won't rebuild
- `cargo check` - only ch3cks if executable can be made
- `cargo build --release`

== Guessing Game
- rust has standard set of libraries (prelude)
- if the type isn't in prelude you have to bring it in scope (import it)
- `String` - growable UTF-8 encoded bit of text by std. library
- `::new` - associated(implemented) func of string type ?
- either use `use std::io` and `io::stdin` or `std::io::stdin`
- `readline` takes std input and append it to the line
- returns `enum` of `Result` type, each possible state is a variant
- `Crates.io` like npm for rust | `Cargo.lock` locks the versions (imp for reproducible builds)
- `cargo update` - updates the locked versions `0.8.0 to 0.9.0`
- `use rand::Rng` - `Rng` is a trait, `gen_rng` is defined by the `Rng` trait ?
- `cargo doc --open` - to see the docs of crates ?
- `match` expression is made up of arms.
- unless specified rust defaults to `i32`
- Rust allows us to shadow the previous value of guess
- `parse` method converts string to other type
- `loop` keyword creates an infinite loop.

```rust
// print doesn't flushes out the stdout like println as println has a `\n`
// if you want a immediate output flush the stdout yourself
io::stdout().flush().unwrap();
```
