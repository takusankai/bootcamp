# if文
x = 10
if x > 5
  puts "xは5より大きい"
end

# unless文
y = 3
unless y > 5
  puts "yは5より大きくない"
end

# case文
puts "「apple」「grape」またはそれ以外を入力 : "
fruit = gets.chomp

case fruit
when "apple"
  puts "それはリンゴです"
when "grape"
  puts "それはブドウです"
else
  puts "それはリンゴでもブドウでもありません"
end

# 真偽値の定義(falseとnil以外は真)
if 0
  puts "0はrubyでは真です"
end

if ""
  puts "空文字列はrubyでは真です"
end

if nil 
else
  puts "nilはrubyでは偽です"
end

# 戻り値の利用
puts result = if fruit.length == 5
  "5文字です"
else
  "5文字ではありません"
end
