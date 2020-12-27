reserved[0]="null"
reserved[1]="Create"
reserved[2]="Database"
reserved[3]="Use"
reserved[4]="Table"
reserved[5]="int"
reserved[6]="string"
for index in ${!reserved[@]}
do
        if [ ${reserved[index]} = $1 ]
        then
                exit 0
        fi
done
exit 1