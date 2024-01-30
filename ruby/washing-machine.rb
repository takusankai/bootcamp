class WashingMachine
  def initialize
    @clothes_array = []
  end

  def add_clothes(clothings)
    if @clothes_array.length < 30
      @clothes_array += clothings
      clothings.each do |a_piece_of_clothes|
        puts "#{a_piece_of_clothes.name}を追加しました。"
      end
    else
      puts "洗濯機の容量が上限を超えてしまうので、これらを新しく追加することはできません。"
    end
  end

  def remove_clothes(clothings)
    @clothes_array -= clothings
    clothings.each do |a_piece_of_clothes|
      puts "#{a_piece_of_clothes.name}を取り出しました。"
    end
  end

  def wash_clothes
    @clothes_array.each do |clothes|
      clothes.cleanliness = true
      puts "#{clothes.name}が清潔になりました。"
    end
  end

  def output_array_status
    puts "以下が洗濯機の中の衣類の一覧です。"
    @clothes_array.each_with_index do |clothes, index|
      puts "#{index} : #{clothes.name} : #{clothes.cleanliness ? '清潔' : '不清潔'}"
    end
    puts "以上の#{@clothes_array.length}点が洗濯機の中の衣類になります。"
  end
end

class Clothes
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

t_shirt_a = Clothes.new('TシャツA')
t_shirt_b = Clothes.new('TシャツB')
t_shirt_c = Clothes.new('TシャツC')

t_shirt_a.use
t_shirt_b.use
t_shirt_c.use

puts "TシャツAは清潔ですか？: #{t_shirt_a.cleanliness ? '清潔' : '不清潔'}"
puts "TシャツBは清潔ですか？: #{t_shirt_b.cleanliness ? '清潔' : '不清潔'}"
puts "TシャツCは清潔ですか？: #{t_shirt_c.cleanliness ? '清潔' : '不清潔'}"

washing_machine.add_clothes([t_shirt_a])
washing_machine.add_clothes([t_shirt_b, t_shirt_c])

washing_machine.output_array_status

washing_machine.wash_clothes

washing_machine.remove_clothes([t_shirt_a])
washing_machine.remove_clothes([t_shirt_b, t_shirt_c])

puts "TシャツAは清潔ですか？: #{t_shirt_a.cleanliness ? '清潔' : '不清潔'}"
puts "TシャツBは清潔ですか？: #{t_shirt_b.cleanliness ? '清潔' : '不清潔'}"
puts "TシャツCは清潔ですか？: #{t_shirt_c.cleanliness ? '清潔' : '不清潔'}"
