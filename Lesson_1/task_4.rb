puts "Веедите коэффициенты уравнения ax**2 + bx + c = 0: "
print "Коэффициент a: "
a = gets.to_f
print "Коэффициент b: "
b = gets.to_f
print "Коэффициент c: "
c = gets.to_f

d = b**2 - 4 * a * c

if d < 0
  print "Дискриминант < 0, Корней нет"
elsif d == 0
    print "Дискриминант = 0, в уравнении один корень = #{-b/(2 * a)}"
else
    print "Дискриминант = #{d}, в уравнении два корня х1=#{(-b + Math.sqrt(d))/(2 * a)} х2=#{(-b - Math.sqrt(d))/(2 * a)}"
end
