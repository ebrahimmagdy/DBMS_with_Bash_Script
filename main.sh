echo "Welcome in your DBMS"

while [ true ]
do
printf "> "
read command

if [ $command = "exit" -o $command = "Exit" ]
then
	echo "bye"
	break
fi

done

./select_db.sh

