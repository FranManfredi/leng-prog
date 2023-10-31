type Fraction = (i32, i32);

/// Add 2 fractions
pub fn add((n1, d1): Fraction, (n2, d2): Fraction) -> Fraction {
    let numerator = n1 * d2 + n2 * d1;
    let denominator = d1 * d2;
    simplify(numerator, denominator)
}

/// Subtract 2 fractions
pub fn sub((n1, d1): Fraction, (n2, d2): Fraction) -> Fraction {
    let numerator = n1 * d2 - n2 * d1;
    let denominator = d1 * d2;
    simplify(numerator, denominator)
}

/// Multiply 2 fractions
pub fn mul((n1, d1): Fraction, (n2, d2): Fraction) -> Fraction {
    let numerator = n1 * n2;
    let denominator = d1 * d2;
    simplify(numerator, denominator)
}

/// Divide 2 fractions
pub fn divide((n1, d1): Fraction, (n2, d2): Fraction) -> Fraction {
    let numerator = n1 * d2;
    let denominator = d1 * n2;
    simplify(numerator, denominator)
}

/// Calculate the Highest common factor between 2 numbers
pub fn hcf(a: i32, b: i32) -> i32 {
    let mut a = a;
    let mut b = b;
    while b != 0 {
        let temp = b;
        b = a % b;
        a = temp;
    }
    a.abs()
}

/// Create a fraction simplifying with the arguments simplified by the `hcf`
pub fn simplify(n: i32, d: i32) -> Fraction {
    let hcf = hcf(n, d);
    (n / hcf, d / hcf)
}
