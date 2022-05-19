basket = {}
sum = 0

loop do
    
puts "Введите название товара:"
item = gets.chomp

if item == "стоп" || item == "stop"
    break
end

puts "Введите цену за единицу:"
price = gets.to_i

puts "Введите количество товара:"
amount = gets.to_f

basket[item] = {price => amount}
sum += price * amount

end

p basket

basket.each { |key, value|
    v = value.to_a 
    puts "Сумма за #{key} = #{v[0][0] * v[0][1]}"
}

puts "Общая сумма корзины = #{sum}"
