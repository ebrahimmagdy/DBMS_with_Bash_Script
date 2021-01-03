#!/bin/bash


SelectDB()
{

echo "Enter the database name: "
read dbname
cd ./DBs/$dbname 2>>/dev/null
if [ $? -eq 0 ]
then
	echo "database selected"
else
	echo "selection failed"
fi
	
}

SelectDB

