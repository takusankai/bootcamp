# 算術演算子
number1 = 10
number2 = 5
addition = number1 + number2  # 足し算
subtraction = number1 - number2  # 引き算
multiplication = number1 * number2  # 掛け算
division = number1 / number2  # 割り算
modulus = number1 % number2  # 余り
puts "足し算: #{addition}"
puts "引き算: #{subtraction}"
puts "掛け算: #{multiplication}"
puts "割り算: #{division}"
puts "余り: #{modulus}"

# 文字列演算子
string1 = "Hello"
string2 = "World"
concatenation = string1 + " " + string2  # 文字列の結合
puts "文字列の結合: #{concatenation}"

# 代入演算子
plus_equals = 10
plus_equals += 5  # プラスイコールの例
puts "x: #{plus_equals}"

# 比較演算子
a = 5
b = 10
greater_than = a > b  # aはbより大きいか
less_than = a < b  # aはbより小さいか
equal_to = a == b  # aはbと等しいか
not_equal_to = a != b  # aはbと等しくないか
puts "aはbより大きいか: #{greater_than}"
puts "aはbより小さいか: #{less_than}"
puts "aはbと等しいか: #{equal_to}"
puts "aはbと等しくないか: #{not_equal_to}"

# 論理演算子
p = true
q = false
logical_and = p && q  # pとqの論理積
logical_or = p || q  # pとqの論理和
logical_not = !p  # pの論理否定
puts "pとqの論理積: #{logical_and}"
puts "pとqの論理和: #{logical_or}"
puts "pの論理否定: #{logical_not}"

# 三項演算子
age = 18
is_adult = age >= 18 ? true : false  # ageが18以上ならtrue、そうでなければfalse
puts "成人か？: #{is_adult}"

# 演算子の優先順位
# 論理否定 > べき乗 " ** " > 乗算・除算・剰余 > 加算・減算 > 比較 > 等・不等 > 論理積 > 三項演算子 > 論理和 > 代入

# 論理系の演算子の結合順序の確認
bool1, bool2, bool3, bool4 = true
result1 = !( bool1 == !bool2 && bool3 || bool4 )
puts "論理計算結果: #{result1}"

# （追記）論理系の演算子の結合順序の追加確認
# 上との違いは、bool4に"!"を加えて、実質的にfalseにしている点
result2 = !( bool1 == !bool2 && bool3 || !bool4 )
puts "（追記）論理計算結果: #{result2}"

# 算術系の演算子の結合順序の確認
number1, number2, number3, number4, number5 = 1, 2, 3, 4, 5
result3 = number1 - number2 * number3 ** ( number4 - number5 )
puts "算術計算結果: #{result3}"
