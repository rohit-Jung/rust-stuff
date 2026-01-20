fn main() {
    println!("Hello, world!");
    let ans = fibo(5);
    println!("5th fibo is {ans}")
}

fn fibo(n: i32) -> i32 {
    if n == 0 {
        return 0;
    }

    if n == 1 {
        return 1;
    }
    fibo(n - 1) + fibo(n - 2)
}

fn fib_match(n: i32) -> i32 {
    match n {
        0 => 0,
        1 => 1,
        _ => fibo(n - 1) + fibo(n - 2),
    }
}
