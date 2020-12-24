db_dir="data/$1/"
db_meta_dir="meta/$1/"
db_meta="${db_meta_dir}$1"
./is_DB_Exist.sh $db_dir
    if [ $? -eq 0 ]
    then
            echo "Error database exist"
    else
            mkdir $db_dir $db_meta_dir
            touch $db_meta
            printf "$1\n0\n" > $db_meta
            #sed -i '1 i\{$1}' $db_meta
            #sed -i '2 i\0' $db_meta
            #gawk -i inplace 'NR == 1 {print "$1","\n"}' $db_meta
            echo "done!"
    fi