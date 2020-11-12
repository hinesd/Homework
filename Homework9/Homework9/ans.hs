ticketCost :: Int -> Int -> Int 
ticketCost speedLimit speed | speed > 85 = 700
                            | speed < speedLimit = 0
                            | (speed - speedLimit) < 12 = (speed - speedLimit) * 20
                            | (speed - speedLimit) >= 12 = (speed - speedLimit) * 40 + 240
                    
arrowN :: Int -> String
arrowN 0 = ">"
arrowN n = "-" ++ arrowN(n-1)

darrowN :: Int -> String
darrowN n = "<" ++ arrowN(n)

line :: Int -> String
line 0 = ""
line n = "-" ++ line(n-1)

box3 :: [String]
box3 = ["***\n","***\n","***\n"]

listParser :: Int -> Int -> [String]
listParser num 0 = []
listParser num n = [line num ++ "\n"] ++ listParser num (n - 1)

box :: Int -> [String]
box 0 = []
box n = listParser n n

doubleAll :: [Int] -> [Int]
doubleAll [] = []
doubleAll (x:xs) = [x * 2] ++ doubleAll(xs)

sumUp :: [Int] -> Int
sumUp [] = 0
sumUp (x:xs) = x + sumUp(xs)

prependAll :: String -> [String] -> [String]
prependAll str [] = []
prependAll str (x:xs) = [x ++ str] ++ prependAll str xs

replaceAll :: Char -> Char -> String -> String
replaceAll char chr "" = ""
replaceAll char chr (x:xs)  | char == x = [chr] ++ replaceAll char chr xs
                            | otherwise = [x] ++ replaceAll char chr xs
                            
flipStr :: String -> String
flipStr "" = ""
flipStr (x:xs) = flipStr xs ++ [x] 

flipX :: [String] -> [String]
flipX [] = []
flipX (x:xs) = [flipStr(x)] ++ flipX xs 

flipY :: [String] -> [String]
flipY [] = []
flipY (x:xs) = flipY xs ++ [x]

newerString :: Int -> String -> String
newerString 0 char = "" 
newerString num char = char ++ newerString (num - 1) char

newString :: Int -> String -> String
newString num "" = ""
newString num (x:xs) = newerString num [x] ++ newString num xs

repeater :: Int -> Int -> String -> [String]
repeater num n "" = []
repeater num 0 string = []
repeater num n string = [newString num string] ++ repeater num (n - 1) string 

zoomIn :: Int -> [String] -> [String]
zoomIn num [] = []
zoomIn num (x:xs) = repeater num num x ++ zoomIn num xs

swapstr :: Char -> Char -> String -> String
swapstr char chr "" = ""
swapstr char chr (x:xs) | char == x = [chr] ++ swapstr char chr xs
                     | chr == x = [char] ++ swapstr char chr xs
                     | otherwise = [x] ++ swapstr char chr xs 

swap :: Char -> Char -> [String] -> [String]
swap char chr [] = []
swap char chr (x:xs) = [swapstr char chr x] ++ swap char chr xs

findMaxHelper :: (Ord a) => a -> [a] -> a
findMaxHelper s [] = s
findMaxHelper s (x:xs) | s < x = findMaxHelper x xs
                       | otherwise = findMaxHelper s xs

findMinHelper :: (Ord a) => a -> [a] -> a
findMinHelper s [] = s
findMinHelper s (x:xs) | s > x = findMinHelper x xs
                       | otherwise = findMinHelper s xs

findMax :: (Ord a) => [a] -> a
findMax (x:xs) = findMaxHelper x xs

findMin :: (Ord a) => [a] -> a
findMin (x:xs) = findMinHelper x xs

mergeMaxHelper :: (Ord a) => a -> a -> [a] -> [a] -> [a]
mergeMaxHelper a b _ [] | a < b = [b] 
                        | otherwise = [a] 
mergeMaxHelper a b [] _ | a < b = [b] 
                        | otherwise = [a]
mergeMaxHelper a b (x:xs) (y:ys) | a < b = b : mergeMaxHelper x y xs ys
                                 | otherwise = a : mergeMaxHelper x y xs ys

mergeMax :: (Ord a) => [a] -> [a] -> [a]
mergeMax _ [] = []
mergeMax [] _ = []
mergeMax (x:xs) (y:ys) = mergeMaxHelper x y xs ys

mergeMinHelper :: (Ord a) => a -> a -> [a] -> [a] -> [a]
mergeMinHelper a b _ [] | a > b = [b] 
                        | otherwise = [a] 
mergeMinHelper a b [] _ | a > b = [b] 
                        | otherwise = [a]
mergeMinHelper a b (x:xs) (y:ys) | a > b = b : mergeMinHelper x y xs ys
                                 | otherwise = a : mergeMinHelper x y xs ys

mergeMin :: (Ord a) => [a] -> [a] -> [a]
mergeMin _ [] = []
mergeMin [] _ = []
mergeMin (x:xs) (y:ys) = mergeMinHelper x y xs ys

scrabblePoints :: [(Char,Int)]
scrabblePoints = [('a',1),('b',3),('c',3),('d',2),('e',1),('f',4),('g',2),('h',4),('i',1),('j',8),('k',5),('l',1),('m',3),('n',1),('o',1),('p',3),('q',10),('r',1),('s',1),('t',1),('u',1),('v',4),('w',4),('x',8),('y',4),('z',10)]

myLookup :: (Eq a) => a -> [(a,Int)] -> Int
myLookup a [] = 0
myLookup a (x:xs) | a == fst x = snd x 
                  | otherwise = myLookup a xs
                  
scoreWord :: String -> Int
scoreWord "" = 0
scoreWord (x:xs) = myLookup x scrabblePoints + scoreWord xs

data Node a = Null | N a (Node a) (Node a) deriving (Show, Eq)

t1 = N 7 Null Null
t2 = N 8 (N 13 Null (N 12 Null Null)) (N 20 Null Null)
t3 = N 8 (N 3 Null Null) (N 20 Null Null)



height :: Node a -> Int
height Null = 0
height (N p Null Null) = 0
height (N p Null right) = 1 + height right
height (N p left Null) = 1 + height left
height (N p left right) | height(left) > height(right) = 1 + height(left)
                        | otherwise = 1 + height(right) 
                        
inTree :: (Eq a) => a -> Node a -> Bool
inTree _ Null = False
inTree a (N p Null right) | a == p = True
                          | otherwise = inTree a right
inTree a (N p left Null) | a == p = True
                         | otherwise = inTree a left   
inTree a (N p left right) | a == p = True
                          | (inTree a left) == True = True
                          | otherwise = inTree a right
                          
numLeaves :: Node a -> Int
numLeaves Null = 0
numLeaves (N _ Null Null) = 1
numLeaves (N _ left right) = numLeaves left + numLeaves right

myMap :: (a -> b) -> [a] -> [b]
myMap _ [] = []
myMap f (x:xs) = f x : myMap f xs

merge :: (a -> b -> c) -> [a] -> [b] -> [c]
merge _ [] b = []
merge _ a [] = []
merge f (x:xs) (y:ys) = f x y : merge f xs ys

numNodes :: Node a -> Int
numNodes Null = 0
numNodes (N _ left Null) = 1 + numNodes left
numNodes (N _ Null right) = 1 + numNodes right
numNodes (N _ left right) = 1 + numNodes left + numNodes right

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter f (x:xs) | f x == True = x : myFilter f xs
                  | otherwise = myFilter f xs