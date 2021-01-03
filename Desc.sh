data_path="data/$1/$2"
meta_path="meta/$1/$2"

./Is_TBL_Exist.sh $data_path
if [ $? -eq 1 ]
then
    echo "Error table doesn't exist!"
    exit 1
fi

echo _______________________________________

awk '{if (NR == 1){print $0}}' $meta_path

echo _______________________________________

echo "| "coulmn name" | "Type"  |"

echo _______________________________________

awk '{if (NR == 5){print "| ", $1, " | primary key |" }}' $meta_path

echo _______________________________________

awk '{if (NR > 5){print "| ", $1, " | ", $2, " |" }}' $meta_path

echo _______________________________________


exit 0