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
condition_col=$3
condition_val=$4

var="$meta_path"_var.tmp""
columns="$meta_path"_columns.tmp""
typs="$meta_path"_typs.tmp""

cat $meta_path | awk '{if (NR == 2) {print "cols="$0} else if (NR == 3) {print "records="$0} else if(NR == 5) {print "primary="$0}}' > $var
cat $meta_path | awk '{if (NR > 5) {print $1}}' > $columns
cat $meta_path | awk '{if (NR > 5) {print $2}}' > $typs

source $var

declare -a col_names

col_names=(`cat "$columns"`)

if [ $condition_col != "null" ]
then
    if [[ ! " ${col_names[@]} " =~ " $condition_col " ]];
    then
        if [ $condition_col != $primary ]
        then
            echo "Error unknown column!"
            error_fun
        fi
    fi
fi

data_tmp="$data_path".tmp""
cat $data_path > $data_tmp
rm $data_path
touch $data_path

deleted=0
i=1
while [ $i -le $records ]
do
    j=-1
    delete=1
    for str in `head -"$i" "$data_tmp" | tail -1`
    do
        if [ $condition_col = "null" ]
        then
            delete=0
            break
        fi
        if [ $j -eq -1 -a $condition_col = $primary -a $condition_val = $str ]
        then
            delete=0
            break
        elif [ $j -eq -1 ]
        then
            j=$(($j + 1))
            continue
        fi
        colName=${col_names[$j]}
        if [ $condition_col = $colName -a $condition_val = $str ]
        then
            delete=0
            break
        fi
        j=$(($j + 1))
    done
    
    if [ $delete = 0 ]
    then
        i=$(($i + 1))
        deleted=$(($deleted + 1))
        continue
    fi
    for str in `head -"$i" "$data_tmp" | tail -1`
    do
        printf "%s " "$str" >> $data_path
    done
    echo  >> $data_path
    i=$(($i + 1))
done

records=$(($records - $deleted))
mete_temp="$meta_path".tmp""
cat $meta_path > $mete_temp
cat $mete_temp | awk -v rec=$records '{if (NR==3){print rec} else {print $0}}' > $meta_path
rm $var $columns $typs $data_tmp $mete_temp 2> /dev/null

exit 0
