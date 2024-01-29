require 'date'
require 'time'
require 'csv'

module TaskLogAccessor
  TASK_LOG='task_log.csv'

  def load_file
    return [] if File.empty?(TASK_LOG)
    CSV.read(TASK_LOG, headers: true)
  end

  def record_file(data_list)
    CSV.open(TASK_LOG, 'w') do |csv|
      csv << ["name", "start_date_time", "end_date_time"]
      data_list.each { |row| csv << row }
    end
  end
end

class TaskRecorder
  include TaskLogAccessor

  def initialize(name: nil)
    @name = name
  end

  def start
    tasks = load_file
    return puts "タスク「#{@name}」はすでに存在しています。" if tasks.any? { |task| task['name'] == @name }
    tasks << [@name, Time.now, nil]
    record_file(tasks)
  end

  def finish
    tasks = load_file
    return puts "タスク「#{@name}」は存在しません。" if tasks.none? { |task| task['name'] == @name }
    target_task = tasks.find { |task| task['name'] == @name }
    return puts "タスク「#{@name}」はすでに終了しています。" if target_task['end_date_time'] != nil
    target_task['end_date_time'] = Time.now
    record_file(tasks)
  end
end

class TaskList
  include TaskLogAccessor

  def initialize
    @tasks = load_file
  end

  def show_today_tasks
    puts "以下が、本日のタスクごと及び累計の作業時間です"
    sum_today_time = 0
    @tasks.each do |task|
      if Date.parse(task['start_date_time']) == Date.today
        task_time = culclate_task_time(task)
        sum_today_time += task_time
        print("タスク「#{task['name']}」の作業時間: ")
        print_hms_style(task_time)
      end
    end
    print("本日の累計作業時間: ")
    print_hms_style(sum_today_time)
  end

  def show_weekly
    puts "以下が、今週の日付ごと及び累計の作業時間です"
    sum_weekly_time, time_each_day = @tasks.reduce([0, Array.new(7, 0)]) do |(sum, times), task|
      if Date.parse(task['start_date_time']) > Date.today - 7
        task_time = culclate_task_time(task)
        sum += task_time
        times[(Date.parse(task['start_date_time']) - Date.today).abs.to_i] += task_time
      end
      [sum, times]
    end
    time_each_day.each_with_index do |daily_time, index|
      print("#{index}日前の作業時間: ")
      print_hms_style(daily_time)
    end
    print("今週の累計作業時間: ")
    print_hms_style(sum_weekly_time)
  end

  def culclate_task_time(task)
    if task['end_date_time'].nil?
      return task_working_time = Time.now - Time.parse(task['start_date_time'])
    end
    task_working_time = Time.parse(task['end_date_time']) - Time.parse(task['start_date_time'])
  end

  def print_hms_style(second_style_time)
    hours = (second_style_time / 3600).floor
    minutes = ((second_style_time % 3600) / 60).floor
    seconds = (second_style_time % 60).floor
    return puts("#{minutes}分#{seconds}秒") if hours == 0
    puts("#{hours}時間#{minutes}分#{seconds}秒")
  end
end

class ArgumentManager
  def initialize(option:, task_name:)
    @option = option
    @task_name = task_name
  end

  def switch_option
    case @option
    when '-s', '--start'
      start_function
    when '-f', '--finish'
      finish_function
    when '-st', '--show-today'
      show_today_function
    when '-sw', '--show-week'
      show_weekly_function
    else
      display_usage
    end
  end

  def start_function
    if @task_name == nil
      display_usage
      return
    end
    task = TaskRecorder.new(name: @task_name)
    task.start
  end

  def finish_function
    if @task_name == nil
      display_usage
      return
    end
    task = TaskRecorder.new(name: @task_name)
    task.finish
  end

  def show_today_function
    task_list = TaskList.new
    task_list.show_today_tasks
  end

  def show_weekly_function
    task_list = TaskList.new
    task_list.show_weekly
  end

  def display_usage
    puts "作業時間を管理するツール"
    puts "Usage: ruby time_tracking_tool.rb [options] [task_name]"
    puts
    puts "ruby time_tracking_tool.rb -s/--start [task_name] : タスクを開始します。"
    puts "ruby time_tracking_tool.rb -f/--finish [task_name] : タスクを終了します。"
    puts "ruby time_tracking_tool.rb -st : 今日のタスクを表示します。"
    puts "ruby time_tracking_tool.rb -sw : 今週の作業時間を表示します。"
  end
end

argument_manager = ArgumentManager.new(option: ARGV[0], task_name: ARGV[1])
argument_manager.switch_option
