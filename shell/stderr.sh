# 標準エラー出力を error.txt にリダイレクトする
# （表示）cat: non-existent-file: No such file or directory
cat non-existent-file 2> error.txt

# >> で追記をする
# （表示）ls: cannot access 'non-existent': No such file or directory
ls non-existent 2>> error.txt