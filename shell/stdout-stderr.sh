if [ $1 == "ok" ]
then
  echo "success: your input is ok" > ok.txt
fi

if [ $1 == "ng" ]
then
  echo "error: your input is ng" >&2 > ng.txt
fi