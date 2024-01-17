if [ $1 == "ok" ]
then
  echo "success: your input is ok" > ok.txt
fi

if [ $1 == "ng" ]
then
  cd non-existent 2> ng.txt
fi