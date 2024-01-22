# 基本のメソッドの戻り値の利用
def add_numbers(a, b)
  return a + b
  a - b # この行は実行されない
end
result = add_numbers(3, 4)
puts "#{result}"

# 真偽値を返すメソッド
def is_even?(number)
  # 単に値を返すだけならreturnは省略できる
  number % 2 == 0
end
puts "6は偶数？ #{is_even?(6)}"
puts "7は偶数？ #{is_even?(7)}"


# デフォルト引数とキーワード引数の利用
def introduce(name = "Yoshioka", age)
  puts "私の名前は#{name}です。年齢は#{age}歳です。"
end
introduce(21)
introduce("default", 15)

def hello(from:, to: "World")
  puts "#{from}: Hello, #{to}!"
end
hello(from: "私") # どの引数なのかを指定する
hello(to: "keyword", from: "unknown") # 引数の順番は関係ない

# 破壊的メソッド
array = [1, 2, 3]
array.pop
puts "変更後の配列: #{array}"

string1 = "hogehoge"
string1.gsub!("hoge", "fuga")
puts "変更後の文字列: #{string1}"

# 引数を破壊的に変更する
def capitalize_string!(string)
  string.capitalize!
end
name = "alice"
capitalize_string!(name)
puts "変更後の名前: #{name}"
