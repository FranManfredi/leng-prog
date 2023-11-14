module Lists (member, union, intersection, difference,
              insert, insertionSort,
              binaryToDecimal, toDecimal, toDec, decimal,
              binaryAdd) where

import Data.Char(digitToInt)

member:: Int -> [Int] -> Bool
member _ []      = False
member e (x:xs)  = e == x || member e xs


union:: [Int] -> [Int] -> [Int]
union [] ys     = ys
union (x:xs) ys
  | member x ys = union xs ys
  | otherwise   = x : union xs ys

-- Remove Implementations, from, here on

intersection:: [Int] -> [Int] -> [Int]
intersection [] _ = []
intersection(x:xs) ys
  |member x ys = x : intersection xs ys
  |otherwise = intersection xs ys


difference:: [Int] -> [Int] -> [Int]
difference  [] _ = []
difference (x:xs) ys
 |not $ member x ys =x: difference xs ys
 |otherwise = difference xs ys

insert::(Ord a) => a -> [a] -> [a]
insert e [] = [e]
insert e (x:xs)
  |e <= x =  e : x : xs
  |e > x = x : insert e xs


insertionSort ::(Ord a) => [a] -> [a]
insertionSort [] = []
insertionSort (x:xs) = insert x(insertionSort xs) 


binaryToDecimal :: [Int] -> Int
binaryToDecimal [] = 0
binaryToDecimal (x:xs)
  |x == 1 = 2 ^ length xs + binaryToDecimal(xs)
  |x == 0 = binaryToDecimal(xs)


toDecimal :: Int -> [Int] -> Int
toDecimal n [] = 0
toDecimal n (x:xs) = x * (n ^ length xs) + toDecimal n (xs)

toDec::Int -> String -> Int
toDec base "" = 0
toDec base (x:xs) = digitToInt(x) * (base ^ length xs) + toDec base (xs) 

-- Same as `toDec` But use a list comprehension

decimal::Int -> String -> Int
decimal base "" = 0
decimal base list = foldr (+) 0 [digitToInt(x) * (base ^ length) | (x,length) <- zip list [length list - 1, length list - 2 .. 0]]

firsts::[a] -> [[a]]
firsts list = [take index list| index <- [1,2 .. length list -1]]

-- Given two String that represents numbers in binary implement the 'binaryAdd' function
-- DO NOT USE a predefined '+' operation

calculateCarry:: Char -> Char-> Char
calculateCarry '0' '0' = '0'
calculateCarry '0' '1' = '0'
calculateCarry '1' '0' = '0'
calculateCarry '1' '1' = '1'

addBit:: Char -> Char -> Char -> Char
addBit '0' '0' '0' = '0'
addBit '0' '0' '1' = '1'
addBit '0' '1' '0' = '1'
addBit '0' '1' '1' = '0'
addBit '1' '0' '0' = '1'
addBit '1' '0' '1' = '0'
addBit '1' '1' '0' = '0'
addBit '1' '1' '1' = '1'

binaryAdd::String -> String -> String
binaryAdd x y = reverse $ binaryAdd' (reverse x) (reverse y) '0'
binaryAdd'::String -> String -> Char -> String
binaryAdd' [] [] '0' = ['0']
binaryAdd' [] [] '1' = ['1']
binaryAdd' (x:xs) [] carry = addBit x '0' carry  : binaryAdd' xs [] (calculateCarry x carry)
binaryAdd' [] (y:ys) carry = addBit '0' y carry  : binaryAdd' [] ys (calculateCarry y carry)
binaryAdd' (x:xs) (y:ys) carry = addBit x y carry : binaryAdd' xs ys (calculateCarry x y)

