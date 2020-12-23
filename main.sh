echo "Welcome in your DBMS"

#check if database exist
is_DB_Exist(){
        local var=$1
        if [ -d $var ]
        then
                echo 0
        else
                echo 1
        fi
}

#create DB
create_DB(){
        local db_dir="data/$1/"
        local db_meta_dir="meta/$1/"
        local db_meta="${db_meta_dir}$1"
        if [ $(is_DB_Exist $db_dir) -eq 0 ]
        then
                echo "Error database exist"
        else
                mkdir $db_dir $db_meta_dir
                touch $db_meta
                sed -i '1ihi' $db_meta
                #gawk -i inplace 'NR == 2 {print $1}' $db_meta
                echo "done!"
        fi
}


#main
while [ true ]

do
printf "> "

read -a command

echo ${command[0]}
echo ${command[0]}

if [ ${command[0]} = "exit" -o ${command[0]} = "Exit" ]
then
	echo "bye"
	break
elif [ ${command[0]} = "Create" -a ${command[1]} = "Database" ]
then
	create_DB ${command[2]}

fi

done


