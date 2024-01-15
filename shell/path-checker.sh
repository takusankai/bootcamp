if [[ "$1" == /* ]]
then
  echo "Absolute Path: $1"
else
  echo "Relative Path: $1"
fi