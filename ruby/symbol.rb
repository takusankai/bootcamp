# Rubyの内部実装では、メソッド名や変数名を整数で管理して検索や比較で活用している
# その整数をRubyのコード上で人間向けに表現したものがシンボルである
# string は mutable で、symbol は immutable である

# string と symbol の比較
str1 = "hoge"
str2 = "hoge"
puts str1.equal?(str2) #=> false
puts str1.object_id    #=> 60
puts str2.object_id    #=> 80

sym1 = :hoge
sym2 = :hoge
puts sym1.equal?(sym2) #=> true
puts sym1.object_id    #=> 1013148
puts sym2.object_id    #=> 1013148

puts str1.class #=> String
puts sym1.class #=> Symbol

puts 'fuga' == :fuga.to_s # シンボルを文字列に変換
puts 'fuga'.to_sym == :fuga # 文字列をシンボルに変換
