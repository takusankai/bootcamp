# 以下は read を無限ループさせている、もしくは単に cat - でもいい。
while read line
do
  echo $line
done