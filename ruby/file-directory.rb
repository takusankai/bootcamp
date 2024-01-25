# ディレクトリの作成
Dir.mkdir("my_directory")

# ファイルの作成と書き込み
File.open("my_directory/my_file.txt", "w") do |file|
  file.write("Hello, world!")
end

# ファイルの読み込み
content = File.read("my_directory/my_file.txt")
puts content

# CSVファイルの読み書き
require 'csv'

# CSVファイルの書き込み
CSV.open("my_directory/my_data.csv", "w") do |csv|
  csv << ["Alice", 20, "alice@example.com"]
  csv << ["Bob", 25, "bob@example.com"]
end

# CSVファイルの読み込み
CSV.foreach("my_directory/my_data.csv") do |row|
  puts row.join(", ")
end

# YAMLファイルの読み書き
require 'yaml'

# YAMLファイルの書き込み
data_YAML = { name: "Alice", age: 20, email: "alice@example.com" }
File.open("my_directory/my_data.yml", "w") do |file|
  file.write(data_YAML.to_yaml)
end

# YAMLファイルの読み込み
content = File.read("my_directory/my_data.yml")
data_YAML = YAML.load(content)
puts data_YAML[:name]

# JSONファイルの読み書き
require 'json'

# JSONファイルの書き込み
data_JSON = { name: "Alice", age: 20, email: "alice@example.com" }
File.open("my_directory/my_data.json", "w") do |file|
  file.write(data_JSON.to_json)
end

# JSONファイルの読み込み
content = File.read("my_directory/my_data.json")
data_JSON = JSON.parse(content)
puts data_JSON["age"]

# 最後にディレクトリ内のファイル一覧を取得
Dir.glob("my_directory/*") do |file|
  puts file
end
