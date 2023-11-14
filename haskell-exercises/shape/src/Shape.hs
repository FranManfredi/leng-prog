module Shape where

data Point = Point { x::Double, y:: Double} deriving (Eq, Show)

data Circle    = Circle    Point Double deriving (Eq, Show)
data Rectangle = Rectangle Point Point deriving (Eq, Show)


-- A point from a tuple Pair
point::(Double, Double) -> Point
point (x,y) = Point {x = x, y = y}

-- The origin
origin::Point
origin = Point {x = 0, y = 0}

-- Rectangle from a Tuple where (x0 y0) == origin
rectangle::(Double, Double) -> Rectangle
rectangle (x,y) = Rectangle origin (point (x,y))

base::Rectangle -> Double
base (Rectangle (Point a b) (Point x y)) = x - a

height::Rectangle -> Double
height (Rectangle (Point a b) (Point x y)) = y - b

-- Circle from radius
circle::Double -> Circle
circle x = Circle origin x 

-- Clase Shift

class Shift a where
   shift::a -> (Double, Double) -> a
   
instance Shift Point where
   shift (Point x y) (a,b) = Point (x + a) (y + b)
   
instance Shift Rectangle where
   shift (Rectangle (Point a b) (Point x y)) (c,d) = (Rectangle (Point (a+c) (b+d)) (Point (x+c) (y+d)))
   
instance Shift Circle where
   shift (Circle (Point a b) x) (c,d)= (Circle (Point (a+c) (b+d)) x)
   
   
class Surface a where 
   surface :: a -> Double

instance Surface Point where
   surface = error "Implement it"

instance Surface Rectangle where
   surface prpr = base prpr * height prpr  

instance Surface Circle where
   surface (Circle (Point a b) x) = pi * x ^ 2 