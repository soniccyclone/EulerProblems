import std/sequtils
import std/sugar
import std/math
  
proc basedSum(bases: seq[int], collection: seq[int]): int =
  return collection
        .filter(num =>
                bases.any(base =>
                          num mod base == 0))
        .foldl(a + b, 0)

proc limitedFib(limit: int): seq[int] =
  result = @[1, 2]
  for x in 3..limit:
    let current = result[^1] + result[^2]
    if current > limit:
      return
    result.add(current)

# Adapted (copy and pasted with some nimthonic edits) from Smitha's Python solution: https://www.geeksforgeeks.org/sieve-of-atkin/
proc sieveOfAtkin(limit: int): seq[int] =
  if limit > 2:
    result.add(2)
  if limit > 3:
    result.add(3)

  var sieve = newSeq[bool](limit+1)

  #[Mark sieve[n] is True if
    one of the following is True:
    a) n = (4*x*x)+(y*y) has odd
    number of solutions, i.e.,
    there exist odd number of
    distinct pairs (x, y) that
    satisfy the equation and
    n % 12 = 1 or n % 12 = 5.
    b) n = (3*x*x)+(y*y) has
    odd number of solutions
    and n % 12 = 7
    c) n = (3*x*x)-(y*y) has
    odd number of solutions,
    x > y and n % 12 = 11 ]#
  var x = 1
  while x * x <= limit:
    var y = 1
    while y * y <= limit:
      # Main part of
      # Sieve of Atkin
      var n = (4 * x * x) + (y * y)
      if (n <= limit and (n mod 12 == 1 or
                          n mod 12 == 5)):
        sieve[n] = sieve[n] xor true

      n = (3 * x * x) + (y * y)
      if n <= limit and n mod 12 == 7:
        sieve[n] = sieve[n] xor true

      n = (3 * x * x) - (y * y)
      if (x > y and n <= limit and
              n mod 12 == 11):
        sieve[n] = sieve[n] xor true
      y += 1
    x += 1
  
  # Mark all multiples of
  # squares as non-prime
  var r = 5
  while r * r <= limit:
    if sieve[r]:
      for i in countup(r * r, limit, r * r):
        sieve[i] = false
    r += 1

  # Add the rest of the primes
  for a in 5..limit:
    if sieve[a]:
      result.add(a)

#Also just copy pasted and adapted from geeksforgeeks
# A function to print all prime factors of
# a given number n
proc primeFactors(target: int64): seq[int64] =
  var n = target
  # Print the number of two's that divide n
  while n mod 2 == 0:
    result.add(2)
    n = (n.float64 / 2).int64
         
    # n must be odd at this point
    # so a skip of 2 ( i = i + 2) can be used
  let top = sqrt(n.float64).int64 + 1
  for i in countup(3i64, top, 2i64):
    # while i divides n , print i and divide n
    while n mod i == 0:
      result.add(i)
      n = (n.float64 / i.float64).int64
           
  # Condition if n is a prime
  # number greater than 2
  if n > 2:
    result.add(n)

echo "Problem 1, Multiples of 3 or 5: ", basedSum(@[3, 5], toSeq(0..1000 - 1))
echo "Problem 2, Even Fibonacci numbers: ", basedSum(@[2], limitedFib(int(4e6)))
echo "Problem 3, Largest prime factor: ", max(primeFactors(600851475143))