var=$1
    if [ -f $var ]
    then
        exit 0
    else
        exit 1
    fi