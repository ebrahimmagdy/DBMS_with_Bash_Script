var=$1
    if [ -d $var ]
    then
            exit 0
    else
            exit 1
    fi