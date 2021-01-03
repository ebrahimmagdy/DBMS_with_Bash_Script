echo "Welcome in your DBMS"

Database="null"

#main
while [ true ]

do

printf "> "  

read -a command

if [ ${#command[@]} -eq "1" -a ${command[0]} = "Exit" ]
then
	echo "bye"
	break
fi
if [ ${#command[@]} -eq "3" -a ${command[0]} = "Create" ]
then
        if [ ${command[1]} = "Database" ]
        then
                ./Create_Database.sh ${command[2]}
                continue
        fi
fi	
if [ ${command[0]} = "Use" ]
then
        ./Use_Database.sh ${command[1]}
        if [ $? -eq 0 ]
        then
                Database=${command[1]}
                echo $Database database is used
                continue      
        fi
fi
if [ ${#command[@]} -eq "3" -a ${command[0]} = "Drop" ]
then
        if [ ${command[1]} = "Database" ]
        then
                ./Drop_Database.sh ${command[2]}
                continue
        fi
fi       
if [ ${#command[@]} -eq "2" -a ${command[0]} = "Show" ]
then
        if [ ${command[1]} = "Databases" ]
        then
                ./Show_Database.sh
                continue
        fi
fi        
if [ ${#command[@]} -eq "2" -a ${command[0]} = "Show" ]
then
        if [ ${command[1]} = "Tables" ]
        then
                ./Show_Tables.sh $Database
                continue
        fi
fi        
if [ ${#command[@]} -eq "3" -a ${command[0]} = "Drop" ]
then
        if [ ${command[1]} = "Table" ]
        then
                ./Drop_Table.sh $Database ${command[2]}
                continue
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
        ./Update_Table.sh $Database ${command[2]}
fi

if [ ${#command[@]} = 2 -a ${command[0]} = "Desc" ]
then
        if [ $Database = "null" ]
        then
                echo "Error no database chosen!"
                continue
        fi
        #if table not exist
        ./Desc.sh $Database ${command[1]}
fi

if [ ${#command[@]} = 3 -a ${command[0]} = "Delete" ]
then
        if [ ${command[1]} != "From" ]
        then
                echo "Error unknown command!"
                continue
        fi
        if [ $Database = "null" ]
        then
                echo "Error no database chosen!"
                continue
        fi
        ./Delete_From_Table.sh $Database ${command[2]} null null
fi

if [ ${#command[@]} = 7 -a ${command[0]} = "Delete" ]
then
        if [ ${command[1]} != "From" -o ${command[3]} != "Where" -o ${command[5]} != "=" ]
        then
                echo "Error unknown command!"
                continue
        fi
        if [ $Database = "null" ]
        then
                echo "Error no database chosen!"
                continue
        fi
        ./Delete_From_Table.sh $Database ${command[2]} ${command[4]} ${command[6]}
fi

echo "Error unknown command!"

done

