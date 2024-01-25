# 現在の日時を取得する
current_time = Time.now
puts "現在の日時: #{current_time}"

# 特定の日時を指定してTimeを作成する
specified_time = Time.new(2024, 1, 24, 23, 59, 59)
puts "指定した日時: #{specified_time}"

# Timeのフォーマットを変更する
formatted_time = current_time.strftime("%Y年%m月%d日 %H時%M分%S秒")
puts "フォーマット変更後の日時: #{formatted_time}"

# 時刻の計算
after_one_hour = Time.now + 3600
puts "1時間後の時刻: #{after_one_hour}"

# 時刻の比較
if specified_time > current_time
  puts "指定した時刻は現在の時刻より後です"
else
  puts "指定した時刻は現在の時刻より前または同じです"
end

# Timeクラスはrequireが不要だが、Dateクラスはrequireが必要
require 'date'

# 現在の日付を取得する
current_date = Date.today
puts "現在の日付: #{current_date}"

# 特定の日付を指定してDateを作成する
specified_date = Date.new(2022, 12, 31)
puts "指定した日付: #{specified_date}"

# Dateのフォーマットを変更する
formatted_date = current_date.strftime("%Y年%m月%d日")
puts "フォーマット変更後の日付: #{formatted_date}"

# 日付の計算
tomorrow = current_date + 1
puts "明日の日付: #{tomorrow}"

# 日付の比較
if specified_date > current_date
  puts "指定した日付は現在の日付より後です"
else
  puts "指定した日付は現在の日付より前または同じです"
end
