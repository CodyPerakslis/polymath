#!/usr/bin/env ruby
=begin Challenge:
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

a^2 + b^2 = c^2

For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.
=end

=begin Method:
Euclid's Formula holds that for any m > n > 0,
a=m^2-n^2, b=2mn, c=m^2+n^2 is a Pythagorean triplet

a+b+c = (m^2-n^2)+2mn+(m^2+n^2) = 2m(m+n) = 1000
  => m(m+n) = 1000/2 = 500

So find the largest value of m < sqrt(500) where m | 500
  n = 500/m - m = X/2m - m

abc = (m^2-n^2)2mn(m^2+n^2) = 2mn(m^4-n^4)
=end

def find_m (val)
  current = Math.sqrt(val/2).ceil()-1
  while val/2 % current > 0 do
    current -= 1
  end
  return current
end

def get_n (val, m)
  return val/(2*m) - m
end

def get_product (m,n)
  return 2*m*n*(m**4 - n**4)
end

$val = 1000
$m = find_m $val
$n = get_n $val, $m
puts "Result: #{get_product $m, $n}"
