data_path="data/$1/$2"
meta_path="meta/$1/$2"

error_fun(){
    rm $var $columns $typs $data_tmp 2> /dev/null
    exit 1
}

./is_TBL_Exist.sh $data_path
if [ $? -eq 1 ]
then
    echo "Error table doesn't exist!"
    error_fun
fi
condition_col=null
condition_val=null

var="$meta_path"_var.tmp""
columns="$meta_path"_columns.tmp""
typs="$meta_path"_typs.tmp""

cat $meta_path | awk '{if (NR == 2) {print "cols="$0} else if (NR == 3) {print "records="$0} else if(NR == 5) {print "primary="$0}}' > $var
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
    col_new_value[${col_names[$i]}]=1
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
    elif [ ${command[0]} = "Where" ]
    then
        if [ ${#command[@]} -ne 4 ]
        then
            echo "Error invalid number of arguments!"
            error_fun
        elif [[ ! " ${col_names[@]} " =~ " ${command[1]} " ]];
        then
            if [ ${command[1]} != $primary ]
            then
                echo "Error unknown column!"
                error_fun
            fi
            condition_col=${command[1]}
            condition_val=${command[3]}
        elif [ ${command[2]} != '=' ]
        then
            echo "Error unknown input!"
            error_fun
        else
            condition_col=${command[1]}
            condition_val=${command[3]}
        fi
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

data_tmp="$data_path".tmp""
cat $data_path > $data_tmp
rm $data_path
touch $data_path

i=1
while [ $i -le $records ]
do    
    j=-1
    update=1
    for str in `head -"$i" "$data_tmp" | tail -1`
    do
        if [ $condition_col = "null" ]
        then
            update=0
            break
        fi
        if [ $j -eq -1 -a $condition_col = $primary -a $condition_val = $str ]
        then
            update=0
            break
        fi
        colName=${col_names[$j]}
        if [ $condition_col = $colName -a $condition_val = $str ]
        then
            update=0
            break
        fi
        j=$(($j + 1))
    done
    j=-1
    for str in `head -"$i" "$data_tmp" | tail -1`
    do
        colName=${col_names[$j]}
        if [ $j -eq -1 ]
        then
            printf "%s " "$str" >> $data_path
        elif [ ${col_new_value[$colName]} != "1" -a $update = "0" ]
        then
            printf "%s " "${col_new_value[$colName]}" >> $data_path
        else
            printf "%s " "$str" >> $data_path
        fi
        j=$(($j + 1))
    done
    echo  >> $data_path
    i=$(($i + 1))
done

rm $data_tmp $var $columns $typs 2> /dev/null
exit 0