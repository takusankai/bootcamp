# 標準エラー出力 Hello, error! を error.txt にリダイレクトする
echo "Hello, error!" >&2 > error.txt

# >> で追記をする
echo "more error" >&2 >> error.txt