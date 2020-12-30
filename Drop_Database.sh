db_dir="data/$1/"
db_meta_dir="meta/$1/"
./Is_DB_Exist.sh $db_dir
    if [ $? -eq 0 ]
    then
            rm -r $db_dir $db_meta_dir
            echo "Database deleted!"
    else
            echo "No such Database!"
    fi