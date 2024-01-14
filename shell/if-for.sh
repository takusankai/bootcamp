for ((i=0; i<16; i++)) do

  echo -n $i

  if [ $(($i % 3)) == 0 ]
  then
    echo -n " fizz"
  fi

  if [ $(($i % 5)) == 0 ]
  then
    echo -n " buzz"
  fi

  echo

done