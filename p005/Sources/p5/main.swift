/* Challenge:
2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
*/

/* Method:
The question is asking for the LCM of the first 20 numbers, so using a priori
knowledge of primes under 20, the cake method allows for the LCM to be
calculated for a list of numbers.
*/

func lcm(end: Int) -> Int {
  let primes = [2,3,5,7,11,13,17,19]
  var arr = Array(2...end)
  var i = 0
  var divides = false
  var result = 1
  while arr.reduce(0,+) > arr.count && i < primes.count {
    divides = false
    for index in 0...(end-2) {
      if arr[index] % primes[i] == 0 {
        arr[index] = arr[index] / primes[i]
        divides = true
      }
    }
    if divides {
      result = result * primes[i]
    } else {
      i = i + 1
    }
  }
  return result
}

print(lcm(end: 20))
