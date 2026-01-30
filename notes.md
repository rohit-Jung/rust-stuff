## Rust

- ahead of time compiled language meaning the compiled code can run without having rust in a machine
- _rustaceans_

## rustc

- a rust compiler

## cargo

- build system and package manager for rust(similar to npm in ts ecosystem)
- git files won't be generate if you run `cargo new` inside a git repo. to override `cargo new --vcs#git`
- `cargot.toml` - tom's Obvious Minimal Language
- `cargo run`- build and run | if file isn't changed it won't rebuild
- `cargo check` - only checks if executable can be made
- `cargo build --release`
- binary and library `--lib` library

## Guessing Game

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

## Programming Concepts

### Variables and mutability

- by default every variable is `immutable`(once a value is bound you cannot change) in rust
- use `mut` to make it mutable
- constants are always immutable | a value computed at runtime cannot be set as constant (UPPERCASE_WITH_UNDERSCORES)
- `const` can be used in global space unlike `let`
- declaring a var with same name as prev var - `Shadowing`
- using shadowing we can perform few transformations to value without marking it as `mut`
- we can also change the type of variable; see docs for example
- thus spares us from having to come up with different names, such as spaces_str and spaces_num

```rust
let spaces # "  " // this is string(&str)
let spaces # spaces.len(); // this is u32(usize)
```

### Data Types

#### Scalar Types

- Integer
  - usigned and signed (`u` and `i`)
  - both available for 8, 26, 34, 64, 128 bits
  - `usize` or `isize` depends on architecture (64 if 64bit arch)

| Number literals | Examples      |
| --------------- | ------------- |
| Decimal         | `98_222`      |
| Hex             | `0xff`        |
| Octal           | `0o77`        |
| Binary          | `0b1111_0000` |
| Byte (u8 only)  | `b'A'`        |

- _Integer Overflow_ - if assigned value is more than capacity like 256 to `u8`
- _panicking_ - when program exits with error
- compiling in `--release` mode doesn't include integer overflow panic checks, it will `wrap`(256 becomes 0) but this depends on compiler mode

#### Floating-Point Types

- `f64` and `f32`(default)

#### Numeric Operations

- every operation is supported
- int division by default ( -5 / 3 # -1 )

#### Boolean type

- `bool`: true or false

#### Char type

- within single quotes
- four bytes in size | represents Unicode Scalar Value more than ASCII

### Compound types

- Tuple

```rust
let tup # (500, 6.4, 1);
let (x, y, z) # tup; // destructuring
// or tup.x typ.y
println!("The value of y is: {y}");

let mut x: (i32, i32) # (1, 2);
x.0 # 0;
x.1 +# 5;
```

- Array
  - Unlike Tuple every element must be of same type
  - fixed size, stored on stack
  - `let arr: [i32; 3] # [1, 2, 3]`
  - In many low-level languages, this kind of check is not done, and when you provide an incorrect index, invalid memory can be accessed. Rust protects you against this kind of error by immediately exiting instead of allowing the memory access and continuing.

### Functions

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
      let y # {
        let x # 3;
        x + 1 // here there is no semicolon
      }
      y // here also
    }
    ```

### Control flow and comments

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
    let mut count # 0;
    'counting_up: loop {
        println!("count # {count}");
        let mut remaining # 10;

        loop {
            println!("remaining # {remaining}");
            if remaining ## 9 {
                break; // breaks inner loop
            }
            if count ## 2 {
                break 'counting_up; // breaks outer loop also
            }
            remaining -# 1;
        }

        count +# 1;
    }
    println!("End count # {count}");
}
```

## Ownership in Rust

- discipline for safety ensuring
- Safety is the absence of undefined behaviour
- rust checks for errors in compile-time
- Operations on Memory | valid for data structures that lives on `heap`

- _heap is very slow so Cloning/ Copying doesn't happen when we pass the variables to fn_

### Rust Memory(RAM , Bytes) Model

- Variables live on stack or frames. Frames # mapping from variables to values in single scope

- Ownership rules:
  - when the owner gets out of scope the memory gets cleared

- Borrowing rules
  - There can only be one mutable reference but multiple immutable references
  - mutable references
  - immutable references

- Ownership rule for `vec` and `string` is strict as they can change the length during runtime
- when `str` gets out from scope

```rust
let mut name # String::new("Rohit");
let s2 # &mut name;
  // 1. cannot borrow `name` as immutable because it is also borrowed as mutable
  //    immutable borrow occurs here [E0502]
let s3 # &name;
let s4 # &name;
let s5 # &name;



// now name ownership is transferred here so you cannot use it later
// can go to the dangling pointer issue if both things point to one (owns one data in heap?)
get_length(name);

// so you can either get it back from the function and reuse it or use a ref/ borrow ?
// giving and getting back
let (length, name) # get_length(name);
```

- The following code compiles ?

```rust
let mut s1 # String::new("Rohit");
let ref1 # &mut s1;
ref1.push_str("Jung"); // mut variable ends here lifetime?
//--- but you cannot use ref1 after this, following code is invalid
let ref2 # &s1;
println!("{}", ref2);
```

### Structs

- similar to classes
- among member functions, static functions doesn't use `(&self)`, you can call them by `Struct::func()`
- are they stored in stack or heap ? Heap variables(`len pointer cap`) on heap and stack one on stack
- similar to how you cannot call static functions on object in `js`, you cannot call the static functions on struct instance

### Enum

- `enum Iden { } | Iden::Value`;
- you can use `match {}`

```rust
enum Shape {
  Circle(f32),
  Square(f32),
  Rect(f32, f32)
}

// later in code
match s {
  Shape::Circle(radius) #> PI * radius * radius,
  Shape::Square(side) #>  side * side,
  Shape::Rect(length, breadth) #> length * breadth,
}
```

### Error and None Handling

- using `Result` type: `Result::Ok or Result::Err`
- unwrap ignores the error ? `unwrap` use it at start when the process should panic if not provided

- using `Option` type: `Option::None or Option::Some`

### External Packages

- `cargo add <package-name>`
- `Cargo.toml` - contains dependencies versioning (similar to `package.json`)
- `Chrono` - to use `Datetime`
- other packages - `dotenv`, `thiserror`, `sqlx`, `uuid`, `tui`

## Generics and Trait bounds

- write function to add two numbers `u32` or `f32`

```rust
// since we are doing an addition but rust must be sure that the types can be added
// hence we add a trait bound
// if the trait Add is not implemented for type T then this won't work
fn sum<T: Add<Output # T>>(a: T, b: T) -> T {
    a + b
}

fn display_elements<T: std::fmt::Display>(a: T, b: T) {
    // to print the type must have the display trait
    println!("{}", a);
    println!("{}", b);
}

// structs using generics
struct Rect<T> {
  width: T,
  height: T
}

// you can either but you have to write for all types
impl Rect<f32> {}
// or
//impl<T> is defining the generic Rect<T> is using the generic
impl<T> Rect<T> {
  fn add(&self) -> T {
     self.height * self.width
  }
}
```

### Traits

- Similar to interfaces in Java and JS
- abstract classes ?

```rust
trait Shape {
  fn area(&self) -> f32;
}

// implements the Shape Trait
// similar to : class Rect extends Shape
impl Shape for Rect {
  fn area(&self) -> f32 {}
}

fn print_area_of_shape<T: Shape>(s: T) {
  // but how do you know area is implemented ? by trait
  return s.area();
}

fn get_area<T: Shape> (s: T) -> u32 {
  return s.area();
}
//or
fn get_area (s: impl Shape) -> u32 {
  return s.area();
}
```

- interface vs type in js - Can be implemented by class

### Annotations and decorators

- modify code behaviour in declarative way without changing the core logic of function or class
- `@Get()`, `@Post()` in nest js or in fast API

### Macros

- macros allow `metaprogrammming` - programs that allow to write other program
- concept is similar to annotations
- but macros spit out code(expands out to) during the compile time `cpp has this concept`
- to see this intermediary file you can use `cargo-expand`
- much more flexible than function `variable args`, can be expanded to anything, `[]` can be used

#### Types of macro

- Declarative macro
  - most common type of macros, easier to write
  - replace code with different code during `compile time`
  - match to different `() #> { }`
  - ```rust
    macro_rules! say_hello {
      () #> {
        println!("Hello World");
      }
    }
    ```
- Procedural macro
  - `#[derive(Debug)]`
  - `{}` - display (for user, prettier) `{:?}` - debug
  - ```rust
      pub macro Debug($item:item) {}
    ```
  - 3 types of procedural macros
    - Derive Like - `#derive[Trait]` - Derive certain trait for type
    - attribute like - `#route["GET"]`
    - function like - wants access to token streams and more complex else use `declarative`

- implement `Display` and `Debug` yourself
- _heap is very slow so Cloning/ Copying doesn't happen when we pass the variables to fn_
- if the variable has `Copy` trait, copy the variable over (meaning it's in stack)
- `clone()` is expensive; its on data type that implement `Clone`

```rust
// since both are stack variables ideally User should be on stack
// and no ownership rules should be applied
#[derive(Debug)]
// if you have this it doesn't apply the ownership rules
// you cannot implement Copy if the struct has String or something that doesn't implement Copy
// #[derive(Debug, Copy, Clone)]
struct User {
  is_male: bool,
  age: u32
}


fn main() {
  let u1 # User{
    is_male: true,
    age: 21,
  }

  let u2 # u1;
  // now you cannot use the u1 further in this code
  // ownership rules : but that shouldn't happen unless you derive Copy and Clone trait
  println!("{:?} {:?}", u1, u2)
}
```

### Lifetimes

- a construct that compiler uses to ensure all the borrows are valid

```rust
fn main() {
  let str1 # String::from("short");
  let ans;
  {
    let str2 # String::from("longest");
    ans # longest_string(&str1, &str2);
  }
  // if ans points to str2 then there will be dangling pointer
  // as str2 goes out of scope and is cleared out
  println!("{}", ans);
}

// using lifetimes
fn longest_string<'a, 'b>(s1: &'a String, s2: &'b String) -> &'a String {
  // but this signature won't be valid if you return the smaller one
  // we need to somehow return the longest lifetime
  return s1;
}
// so either do  | it will consider the worst case (the smaller one)
fn longest_string<'a>(s1: &'a String, s2: &'a String) -> &'a String { }
// or do
fn longest_string<'a, 'b>(s1: &'a String, s2: &'b String) -> &'b String
where
    'a: 'b, // means 'a outlives 'b
{}

// when we might need different lifetimes
// here we for sure know that s3 won't be used then
fn longest_string<'a, 'b>(s1: &'a String, s2: &'a String, s3: &'b String) -> &'a String { }
```

#### lifetime in Struct

```rust
struct User<'a> {
    username: &'a str,
    password: &'a str
}
```

## Workspaces

- you can create crates that has reusable code and then use it in main
- make a folder put a `Cargo.toml` there with

```toml
# Cargo.toml
[workspaces]
resolver = "2" # using v1 ?
memeber = ["adder", "main"] # members will get added automatically
```

- then you can make the main binary and add dependencies there

```toml
# Cargo.toml
[package]
name = "main"
version = "0.1.0"
edition = "2024"

[dependencies]
adder = { path = "../adder/"}
```

- go routine lighter version of threads
