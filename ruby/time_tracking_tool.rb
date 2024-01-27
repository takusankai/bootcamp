require 'date'
require 'time'
require 'json'

module FileIO
  REFERENCE='references.json'

  def read_file
    return [] if File.empty?(REFERENCE)
    JSON.parse(File.read(REFERENCE))
  end

  def write_file(references)
    File.open(REFERENCE, 'w') do |file|
      file.write(JSON.pretty_generate(references))
    end
  end

  def delete_old_file
    references = read_file

    references.each do |reference|
      reference.each do |key, value|
        if Date.parse(value['start_date_time']) < Date.today - 7
          references.delete(reference)
        end
      end
    end

    write_file(references)
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

class TaskList
  include FileIO

  def initialize
    @references = read_file
  end

  def each_task
    @references.each do |reference|
      reference.each do |key, value|
        yield key, value
      end
    end
  end

  def show_today_tasks
    each_task do |key, value|
      next if value['end_date_time'].nil?

      if Date.parse(value['start_date_time']) == Date.today
        start_time = Time.parse(value['start_date_time'])
        end_time = Time.parse(value['end_date_time'])
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

    each_task do |key, value|
      next if value['end_date_time'].nil?

      if Date.parse(value['start_date_time']) >= Date.today - 7
        start_time = Time.parse(value['start_date_time'])
        end_time = Time.parse(value['end_date_time'])
        culc = end_time - start_time
        p "作業時間: #{culc}秒"
        sum += culc
      end
    end

    time = Time.at(sum).utc
    p("今週の累計作業時間: " + time.strftime("%H時間%M分%S秒"))
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
      if @task_name == nil
        usage
        return
      end
      task = Task.new(name: @task_name, start_date_time: Time.now)
      task.start
      task.debug_log_all
    when '-f', '--finish'
      if @task_name == nil
        usage
        return
      end
      task = Task.new(name: @task_name, end_date_time: Time.now)
      task.finish
      task.debug_log_all
    when '-st', '--show-today'
      task_list = TaskList.new
      task_list.show_today_tasks
    when '-sw', '--show-week'
      task_list = TaskList.new
      task_list.show_weekly
    else
      usage
    end
  end

  def usage
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
