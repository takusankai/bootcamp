echo 'bashコマンドで呼ぶ方法'
bash ./calling-b.sh
echo "b_number is" ${b_number}

# この方法のみ、b_numberが2024と表示される
echo 'sourceコマンドで呼ぶ方法'
source ./calling-b.sh
echo "b_number is" ${b_number}
