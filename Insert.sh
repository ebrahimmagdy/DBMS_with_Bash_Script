data_path="data/$1/$2"
meta_path="meta/$1/$2"

error_fun(){
    rm $var $columns $typs $data_tmp 2> /dev/null
    exit 1
}

./Is_TBL_Exist.sh $data_path
if [ $? -eq 1 ]
then
    echo "Error table doesn't exist!"
    error_fun
fi

var="$meta_path"_var.tmp""
columns="$meta_path"_columns.tmp""
typs="$meta_path"_typs.tmp""

cat $meta_path | awk '{if (NR == 2) {print "cols="$0} else if (NR == 3) {print "records="$0} else if (NR == 4) {print "next_pri="$0} else if(NR == 5) {print "primary="$0}}' > $var
cat $meta_path | awk '{if (NR > 5) {print $1}}' > $columns
cat $meta_path | awk '{if (NR > 5) {print $2}}' > $typs

source $var

declare -a col_names
declare -A col_types
declare -A col_new_value

col_names=(`cat "$columns"`)
i=0
for ty in `cat "$typs"`
do

    col_types[${col_names[$i]}]=$ty
    col_new_value[${col_names[$i]}]=null
    i=$(($i + 1))
done

while [ true ]
do
    read -a command
    if [ ${command[0]} = ";" ]
    then
        if [ ${#command[@]} -ne 1 ]
        then
            echo "Error invalid number of arguments!"
            error_fun
        fi
        break
    else
        colName=${command[0]}
        if [ ${#command[@]} -ne 3 ]
        then
            echo "Error invalid number of arguments!"
            error_fun
        elif [[ ! " ${col_names[@]} " =~ " ${command[0]} " ]];
        then
            echo "Error invalid column!"
            error_fun
        elif [ ${command[1]} != "=" ]
        then
            echo "Error unknown input!"
            error_fun
        elif [ ${col_types["$colName"]} = "int" ]
        then
            if [[ ${command[2]} ]] && [ ${command[2]} -eq ${command[2]} 2>/dev/null ]
            then
                echo "no thing" > /dev/null
            else
                echo "Error Can not save string in integer column!"
                error_fun
            fi
        fi
        col_new_value[${command[0]}]=${command[2]}
    fi
done

printf "%d " "$next_pri" >> $data_path
next_pri=$(($next_pri + 1))
for str in ${col_names[@]}
do
    if [ ${col_new_value[$str]} != null ]
    then
        printf "%s " "${col_new_value[$str]}" >> $data_path
    else
        printf "null " >> $data_path
    fi
done
echo >> $data_path
records=$(($records + 1))
mete_temp="$meta_path".tmp""
cat $meta_path > $mete_temp
cat $mete_temp | awk -v rec=$records -v pri=$next_pri '{if (NR==3){print rec} else if (NR == 4){print pri} else {print $0}}' > $meta_path

rm $data_tmp $var $columns $typs $mete_temp 2> /dev/null
exit 0