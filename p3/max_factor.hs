{- Challenge:
The prime factors of 13195 are 5, 7, 13 and 29.
What is the largest prime factor of the number 600851475143 ?
-}

-- Running:
-- `ghci` to enter interactive Haskell
-- `:l max_factor.hs` to load this file
-- `answer` to run this code
-- `:quit` to leave interactive Haskell

{-
Takes a list of possible primes, a list of primes, and the stopping value.
Runs the Sieve of Eratosthenes to fill out the list of primes.
Assumes the first value in the list is a prime,
  if the value is below the stopping criteria
    it adds that value to the end of the prime list
    it removes all factors of that value from the possible primes list
    recurses
  if the value has hit the stopping criteria (sqrt of possible numbers),
    then all the remaining values in the list must be prime
-}
primes :: ([Int],[Int], Int) -> [Int]
primes ([],y,_) = y
primes (a:x, y, h)
    | a <= h = primes (filter (\n -> n `mod` a > 0) x, y ++ [a], h)
    | otherwise = y ++ (a:x)

-- Running the sieve, supplying the right starting variables for primes
sieve :: Int -> [Int]
sieve x
    | x > 1 = primes ([2..x], [], floor $ sqrt $ fromIntegral x)
    | otherwise = []

{-
Takes a number to divide and its largest known factor, supply a list of primes
Return the maximum prime factor.

If there are no more primes, then its largest factor is one of the primes
considered (held in b) or it is a prime outside the list (since the list
should only be up to sqrt of the number to divide), in which case it is what
remains when dividing out all of the prime list.

With another prime, if it is divisible, then divide it. Add the divisor to the
prime list again to take it out multiple times (like 100 = 2*2*5*5). Assumes
primes are held in ascending order, so the latest one is the largest known
factor.
-}
reduced :: (Int, Int) -> [Int] -> Int
reduced (a,b) []
    | a > b = a
    | otherwise = b
reduced (a,b) (h:x)
    | a `mod` h == 0 = reduced (a `div` h,h) (h:x)
    | otherwise = reduced(a,b) x

-- Running the reduced function with the right starting variables
max_factor :: Int -> Int
max_factor x = reduced (x, 1) (sieve (floor $ sqrt $ fromIntegral x))

-- The answer to the question
answer = max_factor 600851475143
