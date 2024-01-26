require 'date'
require 'json'

REFERENCE_PATH="./references.json"

class Task
  attr_accessor :name, :start_date_time, :end_date_time

  def initialize(name: nil, start_date_time: nil, end_date_time: nil)
    @name = name
    @start_date_time = start_date_time
    @end_date_time = end_date_time
  end

  def start
    if File.empty?('references.json')
      references = []
    else
      references = JSON.parse(File.read('references.json'))
    end

    references << { @name => {
      start_date_time: @start_date_time,
      end_date_time: @end_date_time
    }}

    File.open('references.json', 'w') do |file|
      file.write(JSON.pretty_generate(references))
    end
  end

  def finish
    if File.empty?('references.json')
      references = []
    else
      references = JSON.parse(File.read('references.json'))
    end

    references.each do |reference|
      reference.each do |key, value|
        if key == @name
          value["end_date_time"] = @end_date_time
          p value
        end
      end
    end

    File.open('references.json', 'w') do |file|
      file.write(JSON.pretty_generate(references))
    end
  end

  def debug_cheak_task
    if File.empty?('references.json')
      references = []
    else
      references = JSON.parse(File.read('references.json'))
    end

    references.each do |reference|
      reference.each do |key, value|
        if key == @name
          p reference
        end
      end
    end
  end
end

# module file_IO
#   def read_file(refarences)
#     if File.empty?('references.json')
#       references = []
#     else
#       references = JSON.parse(File.read('references.json'))
#     end
#   end

#   def write_file(references)
#     File.open('references.json', 'w') do |file|
#       file.write(JSON.pretty_generate(references))
#     end
#   end
# end


def start_task(task_name)
  now_time = Time.now
  task = Task.new(name: task_name, start_date_time: now_time)
  task.start
  puts "開始したタスク名: #{task_name} 開始時間: #{now_time}"
end

def finish_task(task_name)
  now_time = Time.now
  task = Task.new(name: task_name, end_date_time: now_time)
  task.finish
  puts "終了したタスク名: #{task_name} 終了時間: #{now_time}"
  task.debug_cheak_task
end

def show_today_tasks
  puts "ひとまずここで、全てのタスク一覧"
  if File.empty?('references.json')
    references = []
  else
    references = JSON.parse(File.read('references.json'))
  end

  references.each do |reference|
    reference.each do |key, value|
      p "key: #{key}"
      p "value: #{value}"
      p "value['start_date_time']: #{value['start_date_time']}"
      p "value['end_date_time']: #{value['end_date_time']}"
    end
  end
end

def show_weekly

  puts "今週の作業時間"
end

def usage
  puts "以下が使えるコマンドです。"
  puts "ruby time_tracking_tool.rb -s/--start [task_name] : タスクを開始します。"
  puts "ruby time_tracking_tool.rb -f/--finish [task_name] : タスクを終了します。"
  puts "ruby time_tracking_tool.rb -st : 今日のタスクを表示します。"
  puts "ruby time_tracking_tool.rb -sw : 今週の作業時間を表示します。"
end

def main
  case ARGV[0]
  when '-s', '--start'
    if ARGV[1] != nil
      start_task(ARGV[1])
    else
      usage
    end
  when '-f', '--finish'
    if ARGV[1] != nil
      finish_task(ARGV[1])
    else
      usage
    end
  when '-st', '--show-today'
    show_today_tasks
  when '-sw', '--show-week'
    show_weekly
  else
    usage
  end
end

main
