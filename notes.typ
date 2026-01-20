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
== Programming Concepts

=== Variables and mutability

- by default every variable is `immutable`(once a value is bound you cannot change) in rust
- use `mut` to make it mutable
\
- constants are always immutable | a value computed at runtime cannot be set as constant (UPPERCASE_WITH_UNDERSCORES)
- `const` can be used in global space unlike `let`
\
- declaring a var with same name as prev var - `Shadowing`
- using shadowing we can perform few transformations to value without marking it as `mut`
- we can also change the type of variable; see docs for example
- thus spares us from having to come up with different names, such as spaces_str and spaces_num
```rust
let spaces = "  " // this is string(&str)
let spaces = spaces.len(); // this is u32(usize)
```

=== Data Types

==== Scalar Types
- Integer
  - usigned and signed (`u` and `i`)
  - both available for 8, 26, 34, 64, 128 bits
  - `usize` or `isize` depends on architecture (64 if 64bit arch)

#table(
  align: center,
  columns: 2,
  table.header([*Number literals*], [*Examples*]),
  "Decimal", [98_222],
  "Hex", [0xff],
  "Octal", [0o77],
  "Binary", [0b1111_0000],
  "Byte (u8 only)", [b'A'],
)

- *Integer Overflow* - if assigned value is more than capacity like 256 to `u8`
- *panicking* - when program exits with error
- compiling in `--release` mode doesn't include integer overflow panic checks, it will `wrap`(256 becomes 0) but this depends on compiler mode

==== Floating-Point Types
- `f64` and `f32`(default)

==== Numeric Operations
- every operation is supported
- int division by default ( -5 / 3 = -1 )

==== Boolean type
- `bool`: true or false

==== Char type
- within single quotes
- four bytes in size | represents Unicode Scalar Value more than ASCII

=== Compound types
- Tuple
```rust
let tup = (500, 6.4, 1);
let (x, y, z) = tup; // destructuring
// or tup.x typ.y
println!("The value of y is: {y}");

let mut x: (i32, i32) = (1, 2);
x.0 = 0;
x.1 += 5;
```

- Array
  - Unlike Tuple every element must be of same type
  - fixed size, stored on stack
  - `let arr: [i32; 3] = [1, 2, 3]`
  - In many low-level languages, this kind of check is not done, and when you provide an incorrect index, invalid memory can be accessed. Rust protects you against this kind of error by immediately exiting instead of allowing the memory access and continuing.

=== Functions
- uses snake_case convention
- rust doesn't care if you define fn before or after the main (`just in scope`)
- parameters, concrete values - arguments | requires type annotations
- Statements and expressions
  - inst. that perform some action and do not return value: statement
  - evaluate to value: expression
  - a block `{ .. }` can be statement or syntatic scope
  - expressions doesn't have `;` at the end, if they have that is a statement
  - ```rust
    fn five(x: i32) -> i32 {
      let y = {
        let x = 3;
        x + 1 // here there is no semicolon
      }
      y // here also
    }
    ```

=== Control flow and comments
- comments uses `//` or `/* */`
- Rust does not have a concept of "truthy" or "falsy" values.
- no brackets required in `if condition { }`
- loops: `loop`, `while`, `for`
- you can return from a loop and assign it to a variable also,
- break and continue apply to the inner most loop
- `for element in a` - for in loop also exists
- `Range - (1..4)`
```rust
fn main() {
    let mut count = 0;
    'counting_up: loop {
        println!("count = {count}");
        let mut remaining = 10;

        loop {
            println!("remaining = {remaining}");
            if remaining == 9 {
                break; // breaks inner loop
            }
            if count == 2 {
                break 'counting_up; // breaks outer loop also
            }
            remaining -= 1;
        }

        count += 1;
    }
    println!("End count = {count}");
}
```

