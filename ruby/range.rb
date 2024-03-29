# 1から10までの数値を順に表示する
(1..10).each { |i| puts i }

# 0から9までの数値を順に表示する
(0...10).each { |i| puts i }

# 1から10までの数値の合計を計算する
sum = (1..10).sum
puts "Sum: #{sum}"

# 文字列の範囲指定と含まれているかの判定
string_range = 'a'..'f'
p string_range.include? 'e' # => true
p string_range.include? 'z' # => false

# 日付の範囲指定と含まれているかの判定
require 'date'
date_range = Date.parse('2024-01-01')..Date.parse('2024-01-31')
p date_range.include?(Date.parse('2024-01-19')) # => true
p date_range.include?(Date.parse('2024-02-01')) # => false
