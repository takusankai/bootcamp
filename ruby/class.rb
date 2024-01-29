class User
  def initialize(username, age)
    @username = username
    @age = age
  end

  def hello
    puts "hello, #{@username}"
  end

  def introduce(greet: '')
    puts "#{greet}、#{@username}です。#{@age}歳です。"
  end
end

user1 = User.new("taro", 20)
user2 = User.new("hanako", 25)

user1.hello
user2.hello

user1.introduce(greet: "こんにちは")
user2.introduce()

# rubyに用意されているクラスの利用
# Integerクラス
integer = Integer.new(10)
puts integer + 10       # => 20

# Stringクラス
string = String.new("Hello")
puts string.reverse     # => olleH

# Arrayクラス
array = Array.new([1, 2, 3, 4, 5])
puts array[0]           # => 1

# Hashクラス
hash = Hash.new({ name: "taro", age: 20 })
puts hash[:name]        # => taro
