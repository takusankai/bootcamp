echo 'bashコマンドで呼ぶ方法'
bash ./calling-B.sh
echo "b_number is" ${b_number}

# この方法のみ、b_numberが2024と表示される
echo 'sourceコマンドで呼ぶ方法'
source ./calling-B.sh
echo "b_number is" ${b_number}
