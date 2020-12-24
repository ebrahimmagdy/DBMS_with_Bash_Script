echo "Welcome in your DBMS"

#main
while [ true ]

do
Database="null"

printf "> "  

read -a command

if [ ${command[0]} = "exit" -o ${command[0]} = "Exit" ]
then
	echo "bye"
	break
elif [ ${command[0]} = "Create" -a ${command[1]} = "Database" ]
then
	./Create_Database.sh ${command[2]}
elif [ ${command[0]} = "Use" ]
then
        ./Use_Database.sh ${command[1]}
        if [ $? -eq 0 ]
        then
                Database=${command[1]}
        fi       
fi

done


