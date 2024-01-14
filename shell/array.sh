array1=(1 2 3 4 5)
array2=(A B C D E)

# 配列の1要素を出力
echo $array1
echo $array2
echo ${array1[3]}
echo ${array2[4]}
echo

# 配列を書き換え、全部echo
array1[2]=100
echo -e "${array1[@]} \n"

# forループで1つずつecho
for array2 in ${array2[@]}
do
  echo $array2
done