# module内には関数などが定義が可能で、classにincludeやextendすることで呼び出せる
# classにmoduleをincludeしたりextendすることをMix-inと言う
# classのようにインスタンスの生成や継承はできない

# moduleの例1を定義
module MyModule1
  # 2つの関数を定義
  def greet_world
    puts "Hello, world!"
  end
  def greet_someone(name)
    puts "Hello, #{name}!"
  end
  # 定数を定義
  Age = 21
end

# moduleの例2を定義
module MyModule2
  # 関数を定義
  def class_name
    puts "my name is #{self.class}"
  end
  # module_functionを使い、メソッドをモジュール関数にすると直接呼び出せるようになる
  def instance_function
    puts "instance function"
  end
  module_function :instance_function
end

# classにincludeすることで静的にmoduleの関数を呼び出せるようになる
class MyClass
  include MyModule1
end

object = MyClass.new
object.greet_world           # => "Hello, world!"
object.greet_someone("ruby") # => "Hello, ruby!"

# extendすることで動的な拡張をして呼び出すこともできる
object.extend MyModule2
object.class_name            # => "my name is MyClass"

# moduleの定数は呼び出せる
puts MyModule1::Age          # => 21

# module_functionで指定していない関数は呼び出せない
# MyModule2.class_name

# module_functionで指定した関数は呼び出せる
MyModule2.instance_function  # => "instance function"
