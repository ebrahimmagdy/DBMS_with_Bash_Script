data_path="data/$1/$2"
meta_path="meta/$1/$2"
error_fun(){
    rm $data_path 2> /dev/null
    rm $meta_path 2> /dev/null
    exit 1
}

if [ -f $data_path ]
then
    echo "Error Table exist"
    exit 1
fi
touch $data_path $meta_path
cols=0
echo $2 > $meta_path
echo 0 >> $meta_path #no.columns
echo 0 >> $meta_path #no.records
echo 0 >> $meta_path #primary
echo "Enter the primary key name"
printf "# "
read -a command
./is_Reserved.sh ${command[0]}
if [ $? -eq 0 ]
then
    echo "Error primary key name can't be a reserved word!"
    error_fun
elif [ ${#command[@]} -ne 1 ]
then
    echo "Error number of arguments isn't correct!"
    error_fun
fi
echo ${command[0]} >> $meta_path
cols=$(( $cols + 1 ))
echo 'Enter the coulmns line by line'
echo 'to termenat enter ; in new line'
while [ true ]
do
    printf "# "
    read -a command
    if [ ${command[0]} = ";" ]
    then
        if [ ${#command[@]} -ne 1 ]
        then
            echo "Error number of arguments isn't correct!"
            error_fun
        fi
        echo "Done!"
        echo $cols
        cat $meta_path | awk '/Beam/ {if (NR == 2) {print $cols} else if (NR == 1) {print $0} else {print $0}}'
        exit 0;
    fi
    ./is_Reserved.sh ${command[0]}
    if [ $? -eq 0 ]
    then
        echo "Error table name can't be a reserved word!"
        error_fun
    elif [ ${#command[@]} -ne 2 ]
    then
        echo "Error number of arguments isn't correct!"
        error_fun
    elif [ ${command[1]} != "int" -a ${command[1]} != "string" ]
    then
        echo "Error unknowing column type!"
        error_fun
    fi
    echo "${command[0]} ${command[1]}" >> $meta_path
    cols=$(( $cols + 1 ))
done 
awk '{if (NR == 2) {print $cols} else if (NR == 1) {print $0} else {print $0}}' meta_path
