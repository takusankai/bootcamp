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
      clothing.dryness = false
      puts "#{clothing.name}が清潔になりました。"
    end
  end

  def dry_clothings
    @clothings.each do |clothing|
      clothing.dryness = true
      puts "#{clothing.name}が乾燥機能で乾かされました。"
    end
  end

  def wash_and_dry
    wash_clothings
    dry_clothings
  end

  def output_array_status
    puts "以下が洗濯機の中の衣類の一覧です。"
    @clothings.each_with_index do |clothing, index|
      print "#{index} : #{clothing.name} : #{clothing.cleanliness ? '清潔' : '不清潔'} : "
      puts "#{clothing.dryness ? '乾いている' : '乾いていない'}"
    end
    puts "以上の#{@clothings.length}点が洗濯機の中の衣類になります。"
  end
end

class Clothing
  attr_reader :name
  attr_accessor :cleanliness, :dryness

  def initialize(name, cleanliness = true, dryness = true)
    @name = name
    @cleanliness = cleanliness
    @dryness = dryness
  end

  def use
    if @cleanliness && @dryness
      @cleanliness = false
      puts "#{@name}を使いました。"
    else
      puts "#{@name}は洗濯しないと使えません。" unless @cleanliness
      puts "#{@name}は乾燥しないと使えません。" unless @dryness
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

washing_machine.wash_and_dry

washing_machine.remove_clothings([t_shirt_a])
washing_machine.remove_clothings([t_shirt_b, t_shirt_c])

puts "TシャツAは清潔ですか？: #{t_shirt_a.cleanliness ? '清潔' : '不清潔'}"
puts "TシャツBは清潔ですか？: #{t_shirt_b.cleanliness ? '清潔' : '不清潔'}"
puts "TシャツCは清潔ですか？: #{t_shirt_c.cleanliness ? '清潔' : '不清潔'}"

puts "以下は、追加の乾燥機能に関する一連の確認です。"
t_shirt_d = Clothing.new('TシャツD')
t_shirt_d.use
washing_machine.add_clothings([t_shirt_d])
washing_machine.wash_clothings
washing_machine.output_array_status
washing_machine.dry_clothings
washing_machine.remove_clothings([t_shirt_d])
puts "TシャツAは乾いていますか？: #{t_shirt_d.dryness ? '乾いている' : '乾いていない'}"
