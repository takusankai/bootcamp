require 'date'
require 'time'
require 'csv'

module TaskLogAccessor
  TASK_LOG_FILE_NAME='task_log.csv'

  def load_file
    return [] if File.empty?(TASK_LOG_FILE_NAME)
    CSV.read(TASK_LOG_FILE_NAME, headers: true)
  end

  def record_file(data_list)
    CSV.open(TASK_LOG_FILE_NAME, 'w') do |csv|
      csv << ["name", "start_date_time", "end_date_time"]
      data_list.each { |row| csv << row }
    end
  end
end

class TaskRecorder
  include TaskLogAccessor

  def initialize(name)
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

  def show_today
    puts "以下が、本日のタスクごと及び累計の作業時間です"
    sum_today_time = @tasks.sum do |task|
      if Time.parse(task['start_date_time']).to_date == Date.today
        task_time = culclate_task_time(task)
        print("タスク「#{task['name']}」の作業時間: ")
        print_hms_style(task_time)
        task_time
      end
      0
    end
    print("本日の累計作業時間: ")
    print_hms_style(sum_today_time)
  end

  def show_week
    puts "以下が、今週の日付ごと及び累計の作業時間です"
    time_each_day = @tasks.reduce(Array.new(7, 0)) do |times, task|
      if Time.parse(task['start_date_time']).to_date > Date.today - 7
        task_time = culclate_task_time(task)
        times[(Time.parse(task['start_date_time']).to_date - Date.today).abs.to_i] += task_time
      end
      times
    end
    sum_week_time = time_each_day.sum
    time_each_day.each_with_index do |task_time, index|
      print("#{index}日前の作業時間: ")
      print_hms_style(task_time)
    end
    print("今週の累計作業時間: ")
    print_hms_style(sum_week_time)
  end

  def culclate_task_time(task)
    if task['end_date_time'].nil?
      return Time.now - Time.parse(task['start_date_time'])
    end
    Time.parse(task['end_date_time']) - Time.parse(task['start_date_time'])
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
  def initialize(option:, task_name:, others: [])
    @option = option
    @task_name = task_name
    @others = others
  end

  def switch_option
    return display_usage if @others != []
    case @option
    when '-s', '--start'
      start_function
    when '-f', '--finish'
      finish_function
    when '-st', '--show-today'
      show_today_function
    when '-sw', '--show-week'
      show_week_function
    else
      display_usage
    end
  end

  def start_function
    if @task_name == nil
      display_usage
      return
    end
    task = TaskRecorder.new(@task_name)
    task.start
  end

  def finish_function
    if @task_name == nil
      display_usage
      return
    end
    task = TaskRecorder.new(@task_name)
    task.finish
  end

  def show_today_function
    if @task_name != nil
      display_usage
      return
    end
    task_list = TaskList.new
    task_list.show_today
  end

  def show_week_function
    if @task_name != nil
      display_usage
      return
    end
    task_list = TaskList.new
    task_list.show_week
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

argument_manager = ArgumentManager.new(option: ARGV[0], task_name: ARGV[1], others: (ARGV[2..-1] || []))
argument_manager.switch_option
