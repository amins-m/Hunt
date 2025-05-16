get_certificate_nuclei () {
    input=""
    while read line
    do
            input="$input$line\n"
    done < "${1:-/dev/stdin}"
    echo $input | nuclei -t ~/Downloads/Hunt/nuclei-template/ssl.yaml -silent -j | jq -r '.["extracted-results"][]'
}