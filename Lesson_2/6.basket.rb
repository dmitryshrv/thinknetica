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

basket[item] = {price: price, amount: amount}
sum += price * amount

end

p basket

basket.each { |key, value|
    
    puts "Сумма за #{key} = #{value[:price] * value[:amount]}"
}

puts "Общая сумма корзины = #{sum}"
