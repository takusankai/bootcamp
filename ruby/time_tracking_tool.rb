require 'date'
require 'time'

module FileIO
  REFERENCE='references.csv'
  require 'csv'

  def read_file
    return [] if File.empty?(REFERENCE)
    CSV.read(REFERENCE, headers: true)
  end

  def write_file(data_list)
    CSV.open(REFERENCE, 'w') do |csv|
      csv << ["name", "start_date_time", "end_date_time"]
      data_list.each { |row| csv << row }
    end
  end
end

class Task
  include FileIO

  def initialize(name: nil, start_date_time: nil, end_date_time: nil)
    @name = name
    @start_date_time = start_date_time
    @end_date_time = end_date_time
  end

  def start
    tasks = read_file
    tasks << [@name, @start_date_time, @end_date_time]
    write_file(tasks)
  end

  def finish
    tasks = read_file
    tasks.each do |task|
      if task['name'] == @name
        task['end_date_time'] = @end_date_time
      end
    end
    write_file(tasks)
  end
end

class TaskList
  include FileIO

  def initialize
    @tasks = read_file
  end

  def show_today_tasks
    sum = 0

    @tasks.each do |task|
      next if task['end_date_time'].nil?

      if Date.parse(task['start_date_time']) == Date.today
        start_time = Time.parse(task['start_date_time'])
        end_time = Time.parse(task['end_date_time'])
        culc = end_time - start_time
        p "作業時間: #{culc}秒"
        sum += culc
      end
    end

    time = Time.at(sum).utc
    p("本日の累計作業時間: " + time.strftime("%H時間%M分%S秒"))
  end

  def show_weekly
    delete_old_file
    sum = 0

    @tasks.each do |task|
      next if task['end_date_time'].nil?

      if Date.parse(task['start_date_time']) >= Date.today - 7
        start_time = Time.parse(task['start_date_time'])
        end_time = Time.parse(task['end_date_time'])
        culc = end_time - start_time
        p "作業時間: #{culc}秒"
        sum += culc
      end
    end

    time = Time.at(sum).utc
    p("今週の累計作業時間: " + time.strftime("%H時間%M分%S秒"))
  end

  def delete_old_file
    @tasks.each do |task|
      if Date.parse(task['start_date_time']) < Date.today - 7
        @tasks.delete(task)
      end
    end
    write_file(@tasks)
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
    task = Task.new(name: @task_name, start_date_time: Time.now)
    task.start
  end

  def finish_fanction
    if @task_name == nil
      display_usage
      return
    end
    task = Task.new(name: @task_name, end_date_time: Time.now)
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
