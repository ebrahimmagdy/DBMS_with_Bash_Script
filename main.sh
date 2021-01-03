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
fi

if [ ${#command[@]} = 3 -a ${command[0]} = "Create" ]
then
        if [ ${command[1]} != "Table" ]
        then
                echo "Error unknown command!"
                continue
        fi
        if [ $Database = "null" ]
        then
                echo "Error no database chosen!"
                continue
        fi
        ./is_Reserved.sh ${command[2]}
        if [ $? -eq 0 ]
        then
                echo "Error table name is a reserved word"
                continue
        fi
        ./Create_table.sh $Database ${command[2]}
fi
if [ ${#command[@]} = 3 -a ${command[0]} = "Update" ]
then
        if [ ${command[1]} != "Table" ]
        then
                echo "Error unknown command!"
                continue
        fi
        if [ $Database = "null" ]
        then
                echo "Error no database chosen!"
                continue
        fi
        #if table not exist
        ./Update_Table.sh $Database ${command[2]}
fi

done


