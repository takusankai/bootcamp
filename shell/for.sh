# seqで範囲指定するfor
for i in `seq 5`
do
  echo $i
done

# iの範囲を書く、Cやjavaみたいなfor
for ((i=6; i<11; i++)) do
  echo $i
done

# 配列の全要素だけ回す（添え字が使えないことに注意）
array=(11 12 13 14 15)
for array in ${array[@]}
do
  echo $array
done

# {a..b}というbash独自の範囲の書き方
for i in {16..20}
do
  echo "${i}"
done