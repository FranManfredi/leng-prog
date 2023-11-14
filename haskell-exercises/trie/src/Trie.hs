module Trie  (Trie(..), left, right, find, decode, toList) where

import Bit
  
data Trie a = Leaf a | Trie a :-: Trie a deriving (Show,Read,Eq)
            
left::Trie a -> Trie a
left (Leaf a) = error "hoja no left"
left  (a :-: b) = a 

right::Trie a -> Trie a
right (Leaf a) =  error "hoja no right"
right (a :-: b) = b
  
find::Bits -> Trie a -> a
find [] (Leaf a) = a 
find [] (a :-: b) = error "trie no hojas"
find (x:xs) a 
    | x == T = find xs (right a)
    | otherwise = find xs (left a) 

decode::Bits -> Trie Char -> String
decode list eppe = decodeH list eppe ""
    where   
    decodeH :: Bits -> Trie Char -> String -> String
    decodeH [] (a:-:b) s = s 
    decodeH [] (Leaf a) s = s ++ [a]
    decodeH (x:xs) (Leaf a) s = decodeH (x:xs) eppe (s ++ [a])
    decodeH (x:xs) (a :-: b) s 
        | x == T = decodeH xs b s
        | otherwise = decodeH xs a s
     

toList :: Trie a -> [(a, Bits)]
toList (Leaf a) = [(a, [])]
toList (leftTrie:-:rightTrie) = map (addBits F) (toList leftTrie) ++ map (addBits T) (toList rightTrie)
    where 
        addBits:: Bit -> (a, Bits) -> (a,Bits)
        addBits b (val, bits) = (val, b:bits)