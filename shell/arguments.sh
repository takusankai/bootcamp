echo "first:" "$1"
echo "second:" "$2"
echo "after:" "${@:3:($#-2)}"

for i in ${@}
do
  echo "$i"
done