use rand::Rng;
use std::{
    cmp::Ordering,
    io::{self, Write},
};

fn main() {
    println!("Guessing Game!");
    let random_number = rand::thread_rng().gen_range(1..=100);
    println!("Random number is {random_number}");

    loop {
        print!("Enter your guess: ");

        // print doesn't flushes out the stdout like println as println has a `\n`
        // if you want a immediate output flush the stdout yourself
        io::stdout().flush().unwrap();

        let mut guess = String::new();

        io::stdin()
            .read_line(&mut guess)
            .expect("Error getting stdin");

        let guess: i32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => {
                println!("Please enter a number");
                continue;
            }
        };

        match guess.cmp(&random_number) {
            Ordering::Less => println!("Too little"),
            Ordering::Greater => println!("Too big"),
            Ordering::Equal => {
                println!("You guessed right");
                break;
            }
        }
    }
}
