require 'date'
require 'time'
require 'json'

REFERENCE_PATH="./references.json"

module FileIO
  def read_file
    if File.empty?('references.json')
      []
    else
      JSON.parse(File.read('references.json'))
    end
  end

  def write_file(references)
    File.open('references.json', 'w') do |file|
      file.write(JSON.pretty_generate(references))
    end
  end

  def debug_log_all
    references = read_file

    references.each do |reference|
      reference.each do |key, value|
        if key == @name
          p reference
        end
      end
    end
  end
end

class Task
  include FileIO
  attr_accessor :name, :start_date_time, :end_date_time

  def initialize(name: nil, start_date_time: nil, end_date_time: nil)
    @name = name
    @start_date_time = start_date_time
    @end_date_time = end_date_time
  end

  def start
    references = read_file

    references << { @name => {
      start_date_time: @start_date_time,
      end_date_time: @end_date_time
    }}

    write_file(references)
  end

  def finish
    references = read_file

    references.each do |reference|
      reference.each do |key, value|
        if key == @name
          value["end_date_time"] = @end_date_time
          p value
        end
      end
    end

    write_file(references)
  end
end

def show_today_tasks
  include FileIO
  references = read_file

  sum = 0

  references.each do |reference|
    reference.each do |key, value|
      if value['end_date_time'] != nil
        if Date.parse(value['start_date_time']) == Date.today
          p "今日のreference: #{reference}"
          start_time = Time.parse(value['start_date_time'])
          end_time = Time.parse(value['end_date_time'])
          culc = end_time - start_time
          p "作業時間: #{culc}秒"
          sum += culc
        else
          p "今日でないreference: #{reference}"
        end
      end
    end
  end

  time = Time.at(sum).utc
  p("本日の累計作業時間: " + time.strftime("%H時間%M分%S秒"))
end

def show_weekly
  include FileIO
  references = read_file

  sum = 0

  references.each do |reference|
    reference.each do |key, value|
      if value['end_date_time'] != nil
        # 今日から7日前までの日付を取得
        if Date.parse(value['start_date_time']) >= Date.today - 7
          p "今週のreference: #{reference}"
          start_time = Time.parse(value['start_date_time'])
          end_time = Time.parse(value['end_date_time'])
          culc = end_time - start_time
          p "作業時間: #{culc}秒"
          sum += culc
        else
          p "今週でないreference: #{reference}"
        end
      end
    end
  end

  time = Time.at(sum).utc
  p("今週の累計作業時間: " + time.strftime("%H時間%M分%S秒"))
end

def usage
  puts "Usage: ruby time_tracking_tool.rb [options] [task_name]"
  puts
  puts "ruby time_tracking_tool.rb -s/--start [task_name] : タスクを開始します。"
  puts "ruby time_tracking_tool.rb -f/--finish [task_name] : タスクを終了します。"
  puts "ruby time_tracking_tool.rb -st : 今日のタスクを表示します。"
  puts "ruby time_tracking_tool.rb -sw : 今週の作業時間を表示します。"
end

def main
  case ARGV[0]
  when '-s', '--start'
    if ARGV[1] != nil
      task_name = ARGV[1]
      now_time = Time.now
      task = Task.new(name: task_name, start_date_time: now_time)
      task.start
      puts "開始したタスク名: #{task_name} 開始時間: #{now_time}"
      task.debug_log_all
    else
      usage
    end
  when '-f', '--finish'
    if ARGV[1] != nil
      task_name = ARGV[1]
      now_time = Time.now
      task = Task.new(name: task_name, end_date_time: now_time)
      task.finish
      puts "終了したタスク名: #{task_name} 終了時間: #{now_time}"
      task.debug_log_all
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
