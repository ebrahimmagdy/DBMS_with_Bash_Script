echo "Welcome in your DBMS"
Database="null"
check=0
#main
while [ true ]

do

printf "> "  

read -a command

if [ ${command[0]} = "EXIT" -o ${command[0]} = "exit" -o ${command[0]} = "Exit" -o ${command[0]} = "e" ]
then
	echo "bye"
	break
fi
if [ ${#command[@]} -eq "3" -a ${command[0]} = "Create" -o ${command[0]} = "create" -o ${command[0]} = "CREATE" ]
then
        if [ ${command[1]} = "Database" -o ${command[1]} = "database" -o ${command[1]} = "DATABASE" ]
        then
                ./Create_Database.sh ${command[2]}
                break
        fi
fi	
if [ ${command[0]} = "Use" -o ${command[0]} = "use" -o ${command[0]} = "USE" ]
then
        ./Use_Database.sh ${command[1]}
        if [ $? -eq 0 ]
        then
                check=1
                Database=${command[1]}
                echo $Database database is used      
        fi
fi
if [ ${#command[@]} -eq "3" -a ${command[0]} = "Drop" -o ${command[0]} = "drop" -o ${command[0]} = "DROP" ]
then
        if [ ${command[1]} = "Database" -o ${command[1]} = "database" -o ${command[1]} = "DATABASE" ]
        then
                ./Drop_Database.sh ${command[2]}
                break
        fi
fi       
if [ ${#command[@]} -eq "2" -a ${command[0]} = "Show" -o ${command[0]} = "show" -o ${command[0]} = "SHOW" ]
then
        if [ ${command[1]} = "Database" -o ${command[1]} = "database" -o ${command[1]} = "DATABASE" ]
        then
                ./Show_Database.sh
                break
        fi
fi        
if [ ${#command[@]} -eq "2" -a ${command[0]} = "Show" -o ${command[0]} = "show" -o ${command[0]} = "SHOW" ]
then
        if [ ${command[1]} = "Tables" -o ${command[1]} = "tables" -o ${command[1]} != "TABLES" ]
        then
                ./Show_Tables.sh $Database
                break
        fi
fi        
if [ ${#command[@]} -eq "3" -a ${command[0]} = "Drop" -o ${command[0]} = "drop" -o ${command[0]} = "DROP" ]
then
        if [ ${command[1]} = "Table" -o ${command[1]} = "table" -o ${command[1]} = "TABLE" ]
        then
                ./Drop_Table.sh $Database ${command[2]}
                break
        fi
fi
if [ $check = 0 ]
then
        echo "No valid input"
fi

check=0



done


