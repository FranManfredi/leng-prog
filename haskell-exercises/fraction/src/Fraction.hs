module Fraction (Fraction, add, sub, mul, divide, hcf) where

type Fraction = (Int, Int)

-- Implement the `add` Function

add :: Fraction -> Fraction -> Fraction
add (x,y) (a,b)     | y == b = (x+a,b)
                    | otherwise = (x*b+a*y,b*y)
                    

-- Implement the `sub` Function

sub :: Fraction -> Fraction -> Fraction
sub (x, y) (a, b)
  | y == b    = (x - a, b)
  | otherwise = (x * b - a * y, y * b)

-- Implement the `mul` Function

mul :: Fraction -> Fraction -> Fraction
mul (x,y) (a,b)  = (x*a,y*b)

-- Implement the `divide` Function

divide :: Fraction -> Fraction -> Fraction
divide (x,y) (a,b) = (x*b,a*y)

-- Implement the `hcf` Function

hcf :: Int -> Int -> Int
hcf a 0 = a
hcf a b = hcf b (a `mod` b)


    