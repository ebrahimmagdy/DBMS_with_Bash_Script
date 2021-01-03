var=$1
    if [ -f $var 2> /dev/null ]
    then
        exit 0
    else
        exit 1
    fi