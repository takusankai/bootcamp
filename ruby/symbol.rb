# Rubyの内部実装では、メソッド名や変数名を整数で管理して検索や比較で活用している
# その整数をRubyのコード上で人間向けに表現したものがシンボルである
# string は mutable で、symbol は immutable である

# string と symbol の比較
string1 = "hoge"
string2 = "hoge"
puts string1.equal?(string2) #=> false
puts string1.object_id    #=> 60
puts string2.object_id    #=> 80

symbol1 = :hoge
symbol2 = :hoge
puts symbol1.equal?(symbol2) #=> true
puts symbol1.object_id    #=> 1013148
puts symbol2.object_id    #=> 1013148

puts string1.class #=> String
puts symbol1.class #=> Symbol

puts 'fuga' == :fuga.to_s # シンボルを文字列に変換
puts 'fuga'.to_sym == :fuga # 文字列をシンボルに変換
