# array（配列）の呼び出しには添字、int型の連続した整数を用いる。
# hash（連想配列）の呼び出しにはkey、指定した文字列またはシンボルを用いる。

# 配列の作成と呼び出し
array = [3, 7, 6, 1] # []で囲む
puts array[1]

# ハッシュ（key文字列）の作成と呼び出し
hash_string = { "apple" => 3, "orange" => 7, "grape" => 6, "melon" => 1} # {}で囲む
puts hash_string["orange"]

# ハッシュ（keyシンボル）の作成と呼び出し
hash_symbol = { :apple => 3, :orange => 7, :grape => 6, :melon => 1} # {}で囲む
puts hash_symbol[:orange]

# arrayでのループ
array.each do |number|
  puts number
end

# hashでのループ
# 辞書型は挿入順が保持されないのかと思ったが、Ruby 1.9.3 から挿入順が保持されるようになっていた。
hash_symbol.each do |key, value|
  puts "#{key}: #{value}"
end
