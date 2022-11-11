import std/sequtils
import std/sugar
  
proc basedSum(bases: seq[int], collection: seq[int]): int =
  return collection
        .filter(num => bases.any(base => num mod base == 0))
        .foldl(a + b, 0)

proc limitedFib(limit: int): seq[int] =
  result = @[1, 2]
  for x in 3..limit:
    let current = result[^1] + result[^2]
    if current > limit:
      return
    result.add(current)
    
echo "Problem 1, Multiples of 3 or 5: ", basedSum(@[3, 5], toSeq(0..1000 - 1))
echo "Problem 2, Even Fibonacci numbers: ", basedSum(@[2], limitedFib(int(4e6)))