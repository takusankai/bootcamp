# 正規表現パターン（/囲み）と文字列（"囲み）を作成
pattern = Regexp.new("hello")
# pattern = /hello/ 単にこう書いても同じ
text = "hello world and hello Ruby"

# 正規表現と文字列がマッチする最初の部分を返す
match_result = pattern.match(text)
puts "match_result: #{match_result[0]}"     # => match_result: hello
puts "match_result: #{match_result[1]}"     # => match_result:

# 文字列から正規表現を含む部分すべてを取得
scan_result = text.scan(pattern)
puts "scan_result: #{scan_result}"          # => scan_result: ["hello", "hello"]
puts "scan_result: #{scan_result[1]}"       # => scan_result: hello

# 文字列から正規表現を最初の部分を置換
puts(text.sub(pattern, 'HELLLLLO'))         # => HELLO world and hello Ruby

# 文字列から正規表現を含む部分すべてを置換
puts(text.gsub(pattern, 'HELLLLLO'))        # => helllllo world and helllllo Ruby

# 文字列が正規表現とマッチするかの分岐
if text =~ pattern
  puts "#{text =~ pattern}"                 # => 0
else
  puts "Not matched"
end

# グループ化した正規表現パターンを作成
group_pattern = /(hello) (world) (and)/
result = group_pattern.match(text)
puts "group_result: #{result[0]}"           # => group_result: hello world and
puts "group_result: #{result[1]}"           # => group_result: hello
puts "group_result: #{result[2]}"           # => group_result: Ruby
puts "group_result: #{result[3]}"           # => group_result: and
puts "group_result: #{result[4]}"           # => group_result:

# 名前付きキャプチャグループを含む正規表現パターンを作成
named_pattern = /(?<greeting>hello) (?<target>Ruby)/
result = named_pattern.match(text)
puts result[:greeting]                      # => world
puts result[:target]                        # => Ruby

# メタ文字を含む正規表現パターンを作成
meta_pattern1 = /b+c+/ # bが1回以上の後、cが1回以上
repeat_text = "aaaaabbbbbcccccddddd"
puts "#{repeat_text.match(meta_pattern1)}"  # => bbbbbccccc

meta_pattern2 = /.*d$/ # 任意の文字が0回以上の後、dが1回で終わる
puts "#{repeat_text.match(meta_pattern2)}"  # => aaaaabbbbbcccccddddd
