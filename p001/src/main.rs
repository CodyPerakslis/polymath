/*
Challenge:
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
Find the sum of all the multiples of 3 or 5 below 1000.
*/

fn main() {
    let x = 1000;
    let y1 = 3;
    let y2 = 5;
    let y3 = y1*y2;
    // Inclusion-Exclusion Principle
    // single count union of the factors of 3 and 5 =
    //      (factors_of_3 union factors_of_5) minus (factors_of_3 intersect factors_of_5)
    let z = sum_from_factors(x, y1) + sum_from_factors(x,y2) - sum_from_factors(x,y3);
    println!("{}", z);
}

/*
For x=100, y=3 for example,
3+6+9+...+99 = 3(1+2+3+...+33)
             = 3*33*32/2        Using the sum formula: 1+2+...+n = n(n+1)/2
*/
fn sum_from_factors(x: u32, y: u32) -> u32 {
    let z = (x-1)/y;
    return y*z*(z+1)/2;
}
