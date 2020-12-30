tbl_dir="data/$1/$2"
tbl_meta_dir="meta/$1/$2"
./Is_TBL_Exist.sh $tbl_dir
if [ $? -eq 0 ]
then
    rm $tbl_dir
    rm $tbl_meta_dir
    echo "table deleted!"
elif [ $? -eq 1 ]
then
    echo "no such table!"
fi