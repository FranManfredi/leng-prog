module Frequencies  (Frequency, frequencyMap, frequencies, insert, insertionSort) where

import Data.Map(Map)
import qualified Data.Map as Map
import Data.Tuple(swap)

type Frequency = (Int, Char)

frequencies::String -> [Frequency]
frequencies "" = []
frequencies list = insertionSort (map reverseFrequency (Map.toList (frequencyMap list)))

frequencyMap::(Ord a) => [a] -> Map a Int
frequencyMap list = frecuencyMapH list Map.empty

frecuencyMapH :: (Ord a) => [a] -> Map a Int -> Map a Int
frecuencyMapH [] map  = map
frecuencyMapH (x:xs) map
    |Map.member x map = frecuencyMapH xs (Map.insertWith (+) x 1 map)
    |otherwise = frecuencyMapH xs (Map.insert x 1 map)
    
reverseFrequency:: (Char , Int) -> (Int, Char)
reverseFrequency (c, n) = (n,c)

insert::(Ord a) => a -> [a] -> [a]
insert e [] = [e]
insert e (x:xs)
  |e <= x =  e : x : xs
  |e > x = x : insert e xs


insertionSort ::(Ord a) => [a] -> [a]
insertionSort [] = []
insertionSort (x:xs) = insert x(insertionSort xs) 