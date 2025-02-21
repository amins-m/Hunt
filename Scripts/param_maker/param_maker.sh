param_maker() {
    filename="$1"
    value="$2"
    counter=0
    query_string="?"
    while IFS= read -r keyword
    do
        if [ -n "$keyword" ]
        then
            counter=$((counter+1))
            query_string="${query_string}${keyword}=${value}${counter}&"
        fi
        if [ $counter -eq 25 ]
        then
            echo "${query_string}"
            query_string="?"
            counter=0
        fi
    done < "$filename"
    if [ $counter -gt 0 ]
    then
        echo "${query_string%?}"
    fi
}
