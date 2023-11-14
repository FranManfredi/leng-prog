use std::ops;

#[derive(Debug, PartialEq, Eq)]
pub struct Fraction(pub i32, pub i32);

impl Fraction {
    pub fn sum(&self,Fraction(n1,d1): Fraction) -> Self{
        simplify(self.0 * d1 + self.1 * n1,self.1 * d1)
    }
    pub fn sub(&self,Fraction(n1,d1): Fraction) -> Self{
        simplify(self.0 * d1 - self.1 * n1,self.1 * d1)
    }

    pub fn mul(&self,Fraction(n1,d1): Fraction) -> Self{
        simplify(self.0 * n1, self.1 * d1)
    }
    pub fn divide(&self,Fraction(n1,d1): Fraction) -> Self{
        simplify(self.0 * d1, self.1 * n1)
    }
    
}

impl ops::Add for Fraction {
    type Output = Fraction;
    fn add(self, other: Fraction) -> Fraction {
        self.sum(other)
    }
}

/// Calculate the Highest common factor between 2 numbers
fn hcf(a: i32, b: i32) -> i32 {
    if b == 0 { a } else { hcf(b, a % b) }
}

fn simplify(n: i32, d: i32) -> Fraction {
    let h = hcf(n, d);
    Fraction(n/h, d/h)
}