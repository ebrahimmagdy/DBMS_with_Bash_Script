# DBMS

Database management system made with bash script

# Contents

- [Notes befor start](#Notes befor start)
- [Getting Started](#getting-started)
- [Databases](#Databases)
- [Tables](#Tables)

## Notes
- this language is case sensitive
- reserved words in this language (used by this language) may be not available for users to use as a (database name, table name or column name)

## Getting Started

- To run this project clone this repository and run this commands from terminal
```
    chmod +x *.sh
```

```
    ./main.sh
```
- To exit
```
    Exit
```

## Databases

- Create new database
```
    Create Database database_name
```
- Use database
```
    Use database_name
```
- Show databases
```
    Show Databases
```
- Show tables
```
    Show Tables
```
- Delete database
```
    Drop Database database_name
```

## Tables

- Create
```
    Create Table table_name    
```
the output will be
```
    Enter the primary key name
    #
```
enter the name of the primary key table
```
    Enter the primary key name
    # primary_name
```
then enter the columns information in this format
```
    Enter the coulmns line by line
    to termenat enter ; in new line
    # column1_name data_type
    # column2_name data_type
```
to end insert ";" in new line
```
    # ;
    Done!
```

- Descripe
```
    Desc table_name
```
- Insert
```
    Insert Into table_name
    column1_name = value
    column2_name = value
    ;
```
- Delete data
```
    Delete From table_name Where column_name = value
```
- Update data
```
    Update Table table_name
    column1_name = value
    column2_name = value
    Where column_name = value
    ;
```
- Delete Table
```
    Drop Table table_name
```


## Authors

- AbdElrahman Hassan
- Ibrahim Magdy
