# 基本の配列の作成と要素の取得
fruits = ["apple", "banana", "orange"]
p fruits[0] 

fruits[1] = "grape" # 要素の変更と出力
p fruits

# 配列の演算子
numbers_a = [1, 2, 3, 4]
numbers_b = [3, 4, 5, 6]

concatenate = numbers_a + numbers_b     # 配列の連結
p concatenate # [1, 2, 3, 4, 3, 4, 5, 6]
difference = numbers_a - numbers_b      # 配列の差
p difference # [1, 2]
intersection = numbers_a & numbers_b    # 配列の交差
p intersection # [3, 4]
union = numbers_a | numbers_b           # 配列の和
p union # [1, 2, 3, 4, 5, 6]

# arrayクラスのインスタンスメゾットの利用について
num_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# each: 配列の各要素に対してブロックを実行する。
num_array.each do |number|
  p number * 2
end
p num_array # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]を出力

# map: 配列の各要素に対してブロックを実行し、更にその結果からなる新しい配列を作成する。
twice_num_array = num_array.map do |number|
  number * 2
end
p twice_num_array # [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]を出力

# select: ブロックが真を返した要素からなる新しい配列を作成する。
even_num_array = num_array.select do |number|
  number.even?
end
p even_num_array # 偶数の配列[2, 4, 6, 8, 10]を出力

# reject: selectの逆、ブロックが偽を返した要素からなる新しい配列を作成する。
odd_num_array = num_array.reject do |number|
  number.even?
end
p odd_num_array # 奇数の配列[1, 3, 5, 7, 9]を出力

# reduce: 配列の全ての要素を一つずつ処理して、単一の値にまとめる。
sum = num_array.reduce(0) do |accumulator, number|
  accumulator + number
end
puts "合計: #{sum}" # 合計: 55を出力
