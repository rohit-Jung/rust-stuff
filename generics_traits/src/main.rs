#![allow(dead_code)]
use std::{fmt::Display, ops::Add, ops::Mul};

#[derive(Debug)]
struct User {
    name: String,
}

struct Rect<T> {
    width: T,
    height: T,
}

// or
impl<T> Rect<T>
where
    T: Copy + Mul<Output = T>,
{
    fn add(&self) -> T {
        self.height * self.width
    }
}

impl Display for User {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.name)
    }
}

fn main() {
    println!("Hello, world!");
    sum(1, 2);
    display_elements(1, 2);
    let u1 = User {
        name: String::from("Rohit"),
    };

    print_elem(u1);
}

fn sum<T: Add<Output = T>>(a: T, b: T) -> T {
    a + b
}

fn display_elements<T: std::fmt::Display>(a: T, b: T) {
    // to print the type must have the display trait
    println!("{}", a);
    println!("{}", b);
}

fn print_elem<T: std::fmt::Display>(a: T) {
    println!("{}", a);
}
