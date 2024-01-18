# ディレクトリ作成
mkdir out

# 大ループ
for ((i=0; i<$1; i++))
do

  mkdir out/dir-$((i+1))

  # 小ループ
  for ((j=0; j<=i; j++))
  do
    touch out/dir-$((i+1))/file-$((j+1))
  done

done
