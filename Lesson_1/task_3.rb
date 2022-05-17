
def is_triangle(a,b,c) #существует ли такой треугольник
  (a+b)>c && (a+c)>b && (b+c)>a    
end

puts "Введите три стороны треугольника"
print "1 сторона = "
a = gets.to_f

print "2 сторона = "
b = gets.to_f

print "3 сторона = "
c = gets.to_f

sides = [a,b,c].sort

if is_triangle(a,b,c)

  if sides[2]**2 == sides[1]**2 + sides[0]**2
    print "Треугольник прямоугольный"
  elsif a == b && a == c
    print "Треугольник равносторонний"
  elsif a == b || a == c || b == c
    print "Треугольник равнобедренный"
  elsif
    print "Треугольник не является прямоугольным, равнобедренным, равносторонним"
  end
  
else print "Треугольника с такими сторонами не существует"
end