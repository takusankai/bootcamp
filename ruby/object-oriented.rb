# オブジェクト指向プログラミングの三大要素はカプセル化、ポリモーフィズム、継承である

# カプセル化: 関連性の強いメソッドとインスタンス変数を1つにまとめて粒度の大きいソフトウエア部品を作る
# オブジェクトの内部を隠蔽し外部からのアクセスを制限することで、内部の変更による影響範囲を制限と再利用性を向上が見込める
class Animal
  def initialize(name)
    @name = name
  end

  def speak(content: '')
    puts "#{@name}です！#{content}"
  end
end

# ポリモーフィズム: 同じメソッドでもサブクラス次第で異なる振る舞いをさせる
# 継承: サブクラスで親クラスで定義した内容を使えるようにする
class Dog < Animal
  def speak
    super(content: "わんわん！")
  end
end

class Cat < Animal
  def speak
    puts "にゃーにゃー！"
  end
end

class Pomeranian < Dog
  def cry
    puts "ぽめーーー！"
  end
end

# stringクラスを継承する例
class MyString < String
  def debug_log
    puts "MYSTRING: #{self}"
  end
end

# 呼び出し
dog = Dog.new("ぽち")
dog.speak              # => ぽちです！わんわん！

cat = Cat.new("たま")
cat.speak              # => にゃーにゃー！

pomeranian = Pomeranian.new("ぽめ")
pomeranian.speak       # => ぽめです！わんわん！
pomeranian.cry         # => ぽめーーー！

# 一般的なstringクラスの呼び出し
string = String.new("Hello") # String.newは省略できる
puts string.reverse    # => olleH
# string.debug_log     # => NoMethodErrorになる

# stringクラスを継承したMyStringクラスの呼び出し
my_string = MyString.new("Hello")
puts my_string.reverse # => olleH
my_string.debug_log    # => MYSTRING: Hello
