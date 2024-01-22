# 新しい文字列を作成
my_string = "Hello, world!"

# 文字列を出力
puts my_string

# 文字列の長さを取得
length = my_string.length
puts "長さ: #{length}"

# 文字列が特定の部分文字列を含むか確認
contains_substring = my_string.include?("world")
puts "'world'を含む: #{contains_substring}"

# 文字列を逆順にする
reversed_string = my_string.reverse
puts "逆順: #{reversed_string}"

# 文字列を分割する
split_string = my_string.split(" ")
puts "分割: #{split_string}"

# 文字列の特定の文字を取得する
char_at_index = my_string[1]
puts "インデックス1の文字: #{char_at_index}"

# 文字列の特定の部分を置換する
replaced_string = my_string.gsub("world", "Ruby")
puts "置換: #{replaced_string}"
