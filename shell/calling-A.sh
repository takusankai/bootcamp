echo 'echo `$PATH.sh`で呼ぶ方法'
link=`./calling-B.sh`
echo $link
echo "B_Number is" ${B_Number}

echo 'bashコマンドで呼ぶ方法'
bash ./calling-B.sh
echo "B_Number is" ${B_Number}

# この方法のみ、B_Numberが2024と表示される
echo 'sourceコマンドで呼ぶ方法'
source ./calling-B.sh
echo "B_Number is" ${B_Number}
