# ハッシュ : キーと値のペアを格納するデータ構造
person = { name: "John", age: 21, city: "Tokyo" }

# シンボルを使用した要素のアクセス、変更
p person[:name] # => John
person[:age] = 22

# 要素を追加、削除
person[:occupation] = "Engineer"
person.delete(:city)

# ハッシュの操作
p person.keys        # => [:name, :age, :occupation]
p person.values      # => ["John", 22, "Engineer"]
p person.empty?      # => false
p person.key?(:name) # => true
p person.value?(22)  # => true

# ハッシュの比較
hash1 = {"Ruby":1,"Rails":2,"PHP":3,"Java":4}
hash2 = {"Ruby":1,"Rails":2,"PHP":3,"Java":4}
p hash1 == hash2 # hash1 と hash2 が等しいので true が返る
hash1[:Java] = 5 # "Java" の値を 5 に変更する
p hash1 == hash2 # hash1 と hash2 が等しくないので false が返る

# hash クラスのインスタンスメソッドの利用について

# ハッシュの各要素に対して処理を行う
person.each do |key, value|
  p "Key is #{key} and value is #{value}"
end

# ハッシュの各キーに対して処理を行う
person.each_key do |key|
  p "Key is #{key}"
end

# ハッシュの各値に対して処理を行う
person.each_value do |value|
  p "Value is #{value}"
end

# ハッシュのキーを配列として取得し、それを繰り返し処理する
person.keys.each do |key|
  p "Key is #{key}"
end

# ハッシュの値を配列として取得し、それを繰り返し処理する
person.values.each do |value|
  p "Value is #{value}"
end
