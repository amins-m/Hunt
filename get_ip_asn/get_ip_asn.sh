#!/bin/bash

get_ip_asn () {
    input=""
    while read line
    do
            curl -s https://api.bgpview.io/ip/$line | jq -r ".data.prefixes[0].asn.asn"
    done < "${1:-/dev/stdin}"    
}

get_ip_asn