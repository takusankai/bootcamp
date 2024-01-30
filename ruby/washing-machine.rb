class WashingMachine
  def initialize
    @clothings = []
  end

  def add_clothings(clothings)
    if @clothings.length < 30
      @clothings += clothings
      clothings.each do |clothing|
        puts "#{clothing.name}を追加しました。"
      end
    else
      puts "洗濯機の容量が上限を超えてしまうので、これらを新しく追加することはできません。"
    end
  end

  def remove_clothings(clothings)
    @clothings -= clothings
    clothings.each do |clothing|
      puts "#{clothing.name}を取り出しました。"
    end
  end

  def wash_clothings
    @clothings.each do |clothing|
      clothing.cleanliness = true
      puts "#{clothing.name}が清潔になりました。"
    end
  end

  def output_array_status
    puts "以下が洗濯機の中の衣類の一覧です。"
    @clothings.each_with_index do |clothing, index|
      puts "#{index} : #{clothing.name} : #{clothing.cleanliness ? '清潔' : '不清潔'}"
    end
    puts "以上の#{@clothings.length}点が洗濯機の中の衣類になります。"
  end
end

class Clothing
  attr_reader :name
  attr_accessor :cleanliness

  def initialize(name, cleanliness = true)
    @name = name
    @cleanliness = cleanliness
  end

  def use
    if @cleanliness
      @cleanliness = false
      puts "#{@name}を使いました。"
    else
      puts "#{@name}は洗濯しないと使えません。"
    end
  end
end

washing_machine = WashingMachine.new

t_shirt_a = Clothing.new('TシャツA')
t_shirt_b = Clothing.new('TシャツB')
t_shirt_c = Clothing.new('TシャツC')

t_shirt_a.use
t_shirt_b.use
t_shirt_c.use

puts "TシャツAは清潔ですか？: #{t_shirt_a.cleanliness ? '清潔' : '不清潔'}"
puts "TシャツBは清潔ですか？: #{t_shirt_b.cleanliness ? '清潔' : '不清潔'}"
puts "TシャツCは清潔ですか？: #{t_shirt_c.cleanliness ? '清潔' : '不清潔'}"

washing_machine.add_clothings([t_shirt_a])
washing_machine.add_clothings([t_shirt_b, t_shirt_c])

washing_machine.output_array_status

washing_machine.wash_clothings

washing_machine.remove_clothings([t_shirt_a])
washing_machine.remove_clothings([t_shirt_b, t_shirt_c])

puts "TシャツAは清潔ですか？: #{t_shirt_a.cleanliness ? '清潔' : '不清潔'}"
puts "TシャツBは清潔ですか？: #{t_shirt_b.cleanliness ? '清潔' : '不清潔'}"
puts "TシャツCは清潔ですか？: #{t_shirt_c.cleanliness ? '清潔' : '不清潔'}"
