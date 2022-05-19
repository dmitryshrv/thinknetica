fib = [1]

fib_next = 1

while fib_next < 100 
  fib << fib_next
  fib_next = fib[-1] + fib[-2]
end

print fib
