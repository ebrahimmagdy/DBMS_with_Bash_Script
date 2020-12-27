echo "Welcome in your DBMS"

Database="null"

#main
while [ true ]

do

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
elif [ ${command[0]} = "Create" -a ${command[1]} = "Table" ]
then
        if [ $Database = "null" ]
        then
                echo "Error no database chosen!"
                break
        fi
        is_Reserved ${command[2]}
        if [ $? -eq 0 ]
        then
                echo "Error table name is a reserved word"
                break
        fi
        ./Create_table.sh $Database ${command[2]}
fi

done


