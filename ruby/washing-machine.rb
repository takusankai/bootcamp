class WashingMachine
  def initialize
    @stock_clothes = []
  end

  def add_clothes(clothes)
    if @stock_clothes.length < 30
      @stock_clothes.push(clothes)
      clothes.available = false
      puts "#{clothes.name}を追加しました。"
    else
      puts "洗濯機の容量がmaxなので新しく追加することができません。"
    end
  end

  def remove_clothes(clothes)
    @stock_clothes.delete(clothes)
    clothes.available = true
    puts "#{clothes.name}を取り出しました。"
  end

  def wash_clothes
    @stock_clothes.each do |clothes|
      clothes.cleanliness = true
      puts "#{clothes.name}が清潔になりました。"
    end
  end

  def check_clothes
    puts "以下が洗濯機の中の衣類の一覧です。"
    @stock_clothes.each_with_index do |clothes, index|
      puts "#{index} : #{clothes.name} : #{clothes.cleanliness ? '清潔' : '不清潔'}"
    end
    puts "以上の#{@stock_clothes.length}点が洗濯機の中の衣類になります。"
  end
end

class Clothes
  attr_accessor :name, :cleanliness, :available

  def initialize(name, cleanliness = true, available = true)
    @name = name
    @cleanliness = cleanliness
    @available = available
  end

  def use
    if (@cleanliness == true) && (@available == true)
      @cleanliness = false
      puts "#{@name}を使いました。"
    else
      puts "現在#{@name}は使えません。"
    end
  end

  def is_wearable?
    @cleanliness && @available
  end
end

washing_machine = WashingMachine.new

t_shirt_a = Clothes.new('TシャツA')
t_shirt_b = Clothes.new('TシャツB')

t_shirt_a.use
t_shirt_b.use

puts "TシャツAを着ることができますか？: #{t_shirt_a.is_wearable? ? 'はい' : 'いいえ'}"
puts "TシャツBは着ることができますか？: #{t_shirt_b.is_wearable? ? 'はい' : 'いいえ'}"

washing_machine.add_clothes(t_shirt_a)
washing_machine.add_clothes(t_shirt_b)

washing_machine.check_clothes

washing_machine.wash_clothes

washing_machine.remove_clothes(t_shirt_a)
washing_machine.remove_clothes(t_shirt_b)

puts "TシャツAを着ることができますか？: #{t_shirt_a.is_wearable? ? 'はい' : 'いいえ'}"
puts "TシャツBは着ることができますか？: #{t_shirt_b.is_wearable? ? 'はい' : 'いいえ'}"
