begin
  # ZeroDivisionError: ゼロ除算
  puts 10 / 0
rescue ZeroDivisionError => e
  puts "エラー1 のクラス: #{e.class}"
  puts "エラー1 のメッセージ: #{e.message}"
  puts "エラー1 のバックトレース: #{e.backtrace}"
end

begin
  # NameError: 未定義を参照
  puts hoge
rescue NameError => e
  puts "エラー2 のクラス: #{e.class}"
  puts "エラー2 のメッセージ: #{e.message}"
  puts "エラー2 のバックトレース: #{e.backtrace}"
end

begin
  # NoMethodError: 存在しないメソッドを呼び出し
  puts 10.length
rescue NoMethodError => e
  puts "エラー3 のクラス: #{e.class}"
  puts "エラー3 のメッセージ: #{e.message}"
  puts "エラー3 のバックトレース: #{e.backtrace}"
end

begin
  # TypeError: 型が異なる
  puts 10 + "1"
rescue TypeError => e
  puts "エラー4 のクラス: #{e.class}"
  puts "エラー4 のメッセージ: #{e.message}"
  puts "エラー4 のバックトレース: #{e.backtrace}"
end

begin
  # Math::DomainError: 定義されていない値
  Math.log(-1)
rescue Math::DomainError => e
  puts "エラー5 のクラス: #{e.class}"
  puts "エラー5 のメッセージ: #{e.message}"
  puts "エラー5 のバックトレース: #{e.backtrace}"
end

# 以下は例外を発生させるraiseの例
begin
  # RuntimeErrorとなる
  raise
rescue => e
  puts "エラー6 のクラス: #{e.class}" # => RuntimeError
  puts "エラー6 のメッセージ: #{e.message}"
  puts "エラー6 のバックトレース: #{e.backtrace}"
end

begin
  # RuntimeErrorとなり、メッセージは"エラー7です"となる
  raise "エラー7です"
rescue => e
  puts "エラー7 のクラス: #{e.class}"
  puts "エラー7 のメッセージ: #{e.message}"
  puts "エラー7 のバックトレース: #{e.backtrace}"
end

begin
  # ZeroDivisionErrorとなる
  raise ZeroDivisionError
rescue => e
  puts "エラー8 のクラス: #{e.class}"
  puts "エラー8 のメッセージ: #{e.message}"
  puts "エラー8 のバックトレース: #{e.backtrace}"
end

begin
  # NameErrorとなり、メッセージは"NameErrorです"となる
  raise NameError, "NameErrorです"
rescue => e
  puts "エラー9 のクラス: #{e.class}"
  puts "エラー9 のメッセージ: #{e.message}"
  puts "エラー9 のバックトレース: #{e.backtrace}"
end
