fn main() {
    println!("Hello, world!");
    let mut x = 5;
    // let  x = 5;
    println!("The value of x is: {x}");
    x = 6;
    println!("The value of x is: {x}");

    let spaces = "  "; // this is string
    let spaces: usize = spaces.len(); // this is u32

    println!("{}", -5 / 3);
    let t = ([1; 2], [3; 4]);
    let (a, b) = t;
    println!("{}", t.0[0]);
}
