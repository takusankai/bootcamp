require_relative './time_tracking_tool.rb'
require 'securerandom'

p("↑最初usageが出る" + "-" * 50)

# ランダムにタスク名を生成する
p first_task = SecureRandom.hex(10)
p second_task = SecureRandom.hex(10)
p third_task = SecureRandom.hex(10)
if (first_task == second_task) || (first_task == third_task) || (second_task == third_task)
  puts "生成したタスク名が重複しました。再実行してください。"
  exit
end

p("↑生成したタスク名" + "-" * 50)


# （順当な入力）1つ目のタスクの情報を記録し読み出せるかを確認
ArgumentManager.new(option: "-s", task_name: first_task).switch_option
sleep(2) # 作業時間として2秒間待つ
ArgumentManager.new(option: "-f", task_name: first_task).switch_option
ArgumentManager.new(option: "-st", task_name: nil).switch_option
ArgumentManager.new(option: "-sw", task_name: nil).switch_option
p("-" * 50)

# （順当な入力）タスクの情報が複数になった場合の挙動を確認
ArgumentManager.new(option: "-s", task_name: second_task).switch_option
sleep(2) # 作業時間として2秒間待つ
ArgumentManager.new(option: "-f", task_name: second_task).switch_option
ArgumentManager.new(option: "-st", task_name: nil).switch_option
ArgumentManager.new(option: "-sw", task_name: nil).switch_option
p("-" * 50)

# 想定される引数以外を渡した場合の挙動を確認
# usageを表示する
ArgumentManager.new(option: nil, task_name: nil).switch_option          # 引数がない
p("↑引数無し" + "-" * 50)
ArgumentManager.new(option: "-a", task_name: nil).switch_option         # 定義されていないオプション
p("↑引数無し" + "-" * 50)
ArgumentManager.new(option: "-s", task_name: nil).switch_option         # -s のタスク名がない
p("↑-s名前なし" + "-" * 50)
ArgumentManager.new(option: "-f", task_name: nil).switch_option         # -f のタスク名がない
p("↑-f名前なし" + "-" * 50)
ArgumentManager.new(option: "-st", task_name: first_task).switch_option # -st の引数が多い
p("↑-st引数多" + "-" * 50)
ArgumentManager.new(option: "-sw", task_name: first_task).switch_option # -sw の引数が多い
p("↑-sw引数多" + "-" * 50)

# 例外のコメントを表示する
ArgumentManager.new(option: "-s", task_name: second_task).switch_option # 開始するタスク名が被っている
p("-" * 50)
ArgumentManager.new(option: "-f", task_name: second_task).switch_option # 終了するタスク名が被っている
p("-" * 50)
ArgumentManager.new(option: "-f", task_name: third_task).switch_option  # 存在しないタスクを終了しようとしている
