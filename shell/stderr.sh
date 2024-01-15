# 標準エラー出力を error.txt にリダイレクトする
# （表示）cat: non_existent_file: No such file or directory
cat non_existent_file 2> error.txt

# >> で追記をする
# （表示）ls: cannot access 'exist1': No such file or directory
ls exist1 2>> error.txt