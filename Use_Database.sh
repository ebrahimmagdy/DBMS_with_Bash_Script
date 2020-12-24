./Is_DB_Exist.sh "data/$1"
if [ $? -eq 0 ]
then
    exit 0
else
    echo "Database $1 doesn't exist"
    exit 1
fi