def is_leap(year)
  if year % 400 == 0
    true
  elsif year % 100 == 0
    false
  elsif year % 4 == 0
    true
  else
    false
  end
end 

puts "Введите день: "
day = gets.to_i

puts "Введите месяц: "
month = gets.to_i

puts "Введите год в формате ГГГГ: "
year = gets.to_i

days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_in_month[1] = 29 if is_leap(year)

sum = 0

if month == 1
  puts "Введенная дата имеет #{day} порядок"
else  
  sum = days_in_month[0...month - 1].sum + day
  puts "Введенная дата имеет #{sum} порядок"
end
