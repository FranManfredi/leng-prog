module Huffman (huffmanTrie, encode, decode, Trie(..), Bit(..)) where

import qualified Data.Map as Map
import qualified Data.Foldable as Foldable
import Data.Map (Map)
import Data.Tuple (swap)

type Frequency = (Char, Int)

frequencies :: String -> [(Int, Trie Char)]
frequencies str = insertionSort (map (\(char, freq) -> (freq, Leaf char)) (Map.toList (frequencyMap str)))

frequencyMap :: String -> Map Char Int
frequencyMap [] = error "No"
frequencyMap l = frequencyMapHelper l Map.empty
  where
    frequencyMapHelper :: String -> Map Char Int -> Map Char Int
    frequencyMapHelper [] m = m
    frequencyMapHelper (x : xs) m
      | Map.lookup x m == Nothing = frequencyMapHelper xs (Map.insert x 1 m)
      | otherwise = frequencyMapHelper xs (Map.adjust (+ 1) x m)

insert :: (Ord a) => a -> [a] -> [a]
insert x [] = [x]
insert x (y : ys)
  | x <= y = x : y : ys
  | otherwise = y : insert x ys

insertionSort :: (Ord a) => [a] -> [a]
insertionSort [] = []
insertionSort (x : xs) = foldr insert [x] xs

data Bit = F | T deriving (Eq, Show)
type Bits = [Bit]

data Trie a = Empty
            | Leaf a
            | Trie a :-: Trie a deriving (Eq, Show, Ord)

huffmanTrie :: String -> Trie Char
huffmanTrie "" = Empty
huffmanTrie str = huffmanHelper (frequencies str)
  where
    huffmanHelper :: [(Int, Trie Char)] -> Trie Char
    huffmanHelper (x : xs)
        | length xs == 0 = snd (x)
        | otherwise = huffmanHelper (insertionSort ((fst (x) + fst (head xs), snd x :-: snd (head (xs))) : tail xs))

encode :: String -> Trie Char -> Bits
encode input code = concatMap (\c -> getCode c code) input
  where
    getCode :: Char -> Trie Char -> Bits
    getCode _ Empty = error "Character not found in the Huffman Trie"
    getCode c (Leaf char)
      | c == char = []
      | otherwise = error "Invalid Huffman Trie for encoding"
    getCode c (left :-: right)
      | c `elem` (characters left) = F : getCode c left
      | c `elem` (characters right) = T : getCode c right
      | otherwise = error "Invalid Huffman Trie for encoding"

    characters :: Trie a -> [a]
    characters Empty = []
    characters (Leaf x) = [x]
    characters (left :-: right) = characters left ++ characters right

decode :: Bits -> Trie Char -> String
decode bits trie = decodeHelper bits trie
  where
    decodeHelper :: Bits -> Trie Char -> String
    decodeHelper [] Empty = []
    decodeHelper [] (Leaf char) = [char]
    decodeHelper bits' Empty = error "Invalid Huffman Trie for decoding"
    decodeHelper bits' (Leaf char) = char : decodeHelper bits' trie
    decodeHelper (F : bits') (left :-: _) = decodeHelper bits' left
    decodeHelper (T : bits') (_ :-: right) = decodeHelper bits' right