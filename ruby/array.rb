# 基本の配列の作成と要素の取得
fruits = ["apple", "banana", "orange"]
p fruits[0]

fruits[1] = "grape" # 要素の変更と出力
p fruits

# 配列の演算子
numbers_a = [1, 2, 3, 4]
numbers_b = [3, 4, 5, 6]

concatenate = numbers_a + numbers_b  # 配列の連結
p concatenate                        # => [1, 2, 3, 4, 3, 4, 5, 6]
difference = numbers_a - numbers_b   # 配列の差
p difference                         # => [1, 2]
intersection = numbers_a & numbers_b # 配列の交差
p intersection                       # => [3, 4]
union = numbers_a | numbers_b        # 配列の和
p union                              # => [1, 2, 3, 4, 5, 6]

# arrayクラスのインスタンスメソッドの利用について
number_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# each: 配列の各要素に対してブロックを実行する。
number_array.each do |number|
  p number * 2
end
p number_array                       # => 配列自体に変更はなく[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]を出力する

# map: 配列の各要素に対してブロックを実行し、更にその結果からなる新しい配列を作成する。
twice_number_array = number_array.map do |number|
  number * 2
end
p twice_number_array                 # => 新しく作成された配列 [2, 4, 6, 8, 10, 12, 14, 16, 18, 20] を出力する

# select: ブロックが真を返した要素からなる新しい配列を作成する。
even_number_array = number_array.select do |number|
  number.even?
end
p even_number_array                  # => 偶数の配列 [2, 4, 6, 8, 10] を出力する

# reject: selectの逆、ブロックが偽を返した要素からなる新しい配列を作成する。
odd_number_array = number_array.reject do |number|
  number.even?
end
p odd_number_array                   # => 奇数の配列 [1, 3, 5, 7, 9] を出力する

# reduce: 配列の全ての要素を一つずつ処理して、単一の値にまとめる。
sum = number_array.reduce(0) do |accumulator, number|
  accumulator + number
end
puts "sum: #{sum}"                   # => 合計である 55 を出力する
