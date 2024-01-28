module FileIO
  REFERENCE='references.csv'
  require 'csv'

  def load_file
    return [] if File.empty?(REFERENCE)
    CSV.read(REFERENCE, headers: true)
  end

  def record_file(data_list)
    CSV.open(REFERENCE, 'w') do |csv|
      csv << ["name", "start_date_time", "end_date_time"]
      data_list.each { |row| csv << row }
    end
  end
end

class TaskRecorder
  include FileIO

  def initialize(name: nil, start_date_time: nil, end_date_time: nil)
    @name = name
    @start_date_time = start_date_time
    @end_date_time = end_date_time
  end

  def start
    tasks = load_file
    return p "タスク「#{@name}」はすでに存在しています。" if tasks.any? { |task| task['name'] == @name }
    tasks << [@name, @start_date_time, @end_date_time]
    record_file(tasks)
  end

  def finish
    tasks = load_file
    return p "タスク「#{@name}」は存在しません。" if tasks.none? { |task| task['name'] == @name }
    tasks.each { |task| task['end_date_time'] = @end_date_time if task['name'] == @name }
    record_file(tasks)
  end
end

class TaskList
  require 'date'
  require 'time'
  include FileIO

  def initialize
    @tasks = load_file
  end

  def show_today_tasks
    today_sum_time = 0
    @tasks.each do |task|
      if Date.parse(task['start_date_time']) == Date.today
        today_sum_time += culclate_task_time(task)
      end
    end
    display_HHMMSS(today_sum_time)
  end

  def show_weekly
    delete_old_file
    weekly_sum_time = 0
    @tasks.each do |task|
      weekly_sum_time += culclate_task_time(task)
    end
    display_HHMMSS(weekly_sum_time)
  end

  def culclate_task_time(task)
    if task['end_date_time'].nil?
      task_working_time = Time.now - Time.parse(task['start_date_time'])
    end
    start_time = Time.parse(task['start_date_time'])
    end_time = Time.parse(task['end_date_time'])
    task_working_time = end_time - start_time
    p "タスク「#{task['name']}」の作業時間: #{task_working_time}秒"
    return task_working_time
  end

  def display_HHMMSS(time)
    hours = (time / 3600).floor
    minutes = ((time % 3600) / 60).floor
    seconds = (time % 60).floor
    p("累計作業時間: #{hours}時間#{minutes}分#{seconds}秒")
  end

  def delete_old_file
    @tasks.delete_if do |task|
      Date.parse(task['start_date_time']) <= Date.today - 7
    end
    record_file(@tasks)
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
      start_fanction
    when '-f', '--finish'
      finish_fanction
    when '-st', '--show-today'
      show_today_fanction
    when '-sw', '--show-week'
      show_weekly_fanction
    else
      display_usage
    end
  end

  def start_fanction
    if @task_name == nil
      display_usage
      return
    end
    task = TaskRecorder.new(name: @task_name, start_date_time: Time.now)
    task.start
  end

  def finish_fanction
    if @task_name == nil
      display_usage
      return
    end
    task = TaskRecorder.new(name: @task_name, end_date_time: Time.now)
    task.finish
  end

  def show_today_fanction
    task_list = TaskList.new
    task_list.show_today_tasks
  end

  def show_weekly_fanction
    task_list = TaskList.new
    task_list.show_weekly
  end

  def display_usage
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
