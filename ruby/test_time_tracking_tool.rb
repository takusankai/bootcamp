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

# タスクの情報を記録し読み出し作業で問題が起こらないかを確認
ArgumentManager.new(option: "-s", task_name: first_task).switch_option
ArgumentManager.new(option: "-s", task_name: first_task).switch_option    # 直後に同じタスクを開始しようとする
ArgumentManager.new(option: "-s", task_name: second_task).switch_option   # 他のタスクを開始する
sleep(2) # 作業時間として2秒間待つ
ArgumentManager.new(option: "-f", task_name: first_task).switch_option
ArgumentManager.new(option: "-f", task_name: first_task).switch_option    # 直後に同じタスクを終了しようとする
ArgumentManager.new(option: "-st", task_name: nil).switch_option          # 終了していないタスクがある状態で表示
ArgumentManager.new(option: "-sw", task_name: nil).switch_option          # 終了していないタスクがある状態で表示
p("-" * 50)
ArgumentManager.new(option: "-f", task_name: second_task).switch_option
ArgumentManager.new(option: "-st", task_name: nil).switch_option          # 終了していないタスクがない状態で表示
ArgumentManager.new(option: "-sw", task_name: nil).switch_option          # 終了していないタスクがない状態で表示

# 何らかのオプションを渡した場合のみ、例外の挙動を確認
if ARGV[0] != nil
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
  ArgumentManager.new(option: "-sw", task_name: first_task, others: ["xxx"]).switch_option
  p("↑過剰引数（3つ）" + "-" * 50)                                          # 3つ引数を渡されている
  ArgumentManager.new(option: "-sw", task_name: first_task, others: ["xxx", "yyy", "zzz"]).switch_option
  p("↑過剰引数（5つ）" + "-" * 50)                                          # 3つ以上引数を渡されている

  # 例外のコメントを表示する
  ArgumentManager.new(option: "-s", task_name: second_task).switch_option # 開始するタスク名が被っている
  p("-" * 50)
  ArgumentManager.new(option: "-f", task_name: second_task).switch_option # 終了するタスク名が被っている
  p("-" * 50)
  ArgumentManager.new(option: "-f", task_name: third_task).switch_option  # 存在しないタスクを終了しようとしている
end
