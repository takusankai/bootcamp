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
      clothes.dryness = false
      puts "#{clothes.name}が清潔になりました。"
    end
  end

  def dry_clothes
    @clothes_array.each do |clothes|
      clothes.dryness = true
      puts "#{clothes.name}が乾燥機能で乾かされました。"
    end
  end

  def wash_and_dry
    wash_clothes
    dry_clothes
  end

  def output_array_status
    puts "以下が洗濯機の中の衣類の一覧です。"
    @clothes_array.each_with_index do |clothes, index|
      print "#{index} : #{clothes.name} : #{clothes.cleanliness ? '清潔' : '不清潔'} : "
      puts "#{clothes.dryness ? '乾いている' : '乾いていない'}"
    end
    puts "以上の#{@clothes_array.length}点が洗濯機の中の衣類になります。"
  end
end

class Clothes
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

washing_machine.wash_and_dry

washing_machine.remove_clothes([t_shirt_a])
washing_machine.remove_clothes([t_shirt_b, t_shirt_c])

puts "TシャツAは清潔ですか？: #{t_shirt_a.cleanliness ? '清潔' : '不清潔'}"
puts "TシャツBは清潔ですか？: #{t_shirt_b.cleanliness ? '清潔' : '不清潔'}"
puts "TシャツCは清潔ですか？: #{t_shirt_c.cleanliness ? '清潔' : '不清潔'}"

puts "以下は、追加の乾燥機能に関する一連の確認です。"
t_shirt_d = Clothes.new('TシャツD')
t_shirt_d.use
washing_machine.add_clothes([t_shirt_d])
washing_machine.wash_clothes
washing_machine.output_array_status
washing_machine.dry_clothes
washing_machine.remove_clothes([t_shirt_d])
puts "TシャツAは乾いていますか？: #{t_shirt_d.dryness ? '乾いている' : '乾いていない'}"
